// functions/index.js
// MQTT ingestion + Express APIs + Scheduled aggregator for EaseMilker

require('dotenv').config();
const mqtt = require('mqtt');
const admin = require('firebase-admin');
const express = require('express');
const cors = require('cors');
const pino = require('pino');
const crypto = require('crypto');
const pLimit = require('p-limit');

const logger = pino({ level: process.env.LOG_LEVEL || 'info' });

// Firebase Admin initialization
// Uses ADC or explicit service account via GOOGLE_APPLICATION_CREDENTIALS
if (!admin.apps.length) {
  try {
    admin.initializeApp({
      projectId: process.env.FIREBASE_PROJECT_ID,
    });
    logger.info({ projectId: process.env.FIREBASE_PROJECT_ID }, 'Firebase Admin initialized');
  } catch (e) {
    logger.error({ err: e }, 'Failed to initialize Firebase Admin');
    process.exit(1);
  }
}
const db = admin.firestore();
const auth = admin.auth();
const messaging = admin.messaging();

// -------- MQTT Ingestion ---------
const MQTT_BROKER_URL = process.env.MQTT_BROKER_URL; // e.g., mqtts://your-host:8883
if (!MQTT_BROKER_URL) {
  logger.warn('MQTT_BROKER_URL not set; ingestion will not start.');
}

const mqttOptions = {
  clientId: process.env.MQTT_CLIENT_ID || `easemilker-ingestor-${Math.random().toString(16).slice(2)}`,
  username: process.env.MQTT_USERNAME,
  password: process.env.MQTT_PASSWORD,
  clean: true,
  keepalive: Number(process.env.MQTT_KEEPALIVE_SECONDS || 60),
  reconnectPeriod: 0 // we handle backoff manually
};

const SUB_TOPICS = [
  'easemilker/+/data',
  'easemilker/+/status',
  'easemilker/+/alert'
];

// In-memory dedup (process lifespan). Prefer deterministic Firestore doc IDs for true idempotency.
const seenMessageIds = new Set();
const SEEN_TTL_MS = 15 * 60 * 1000; // 15 minutes
setInterval(() => seenMessageIds.clear(), SEEN_TTL_MS).unref();

function computeMessageId(topic, payload) {
  try {
    const body = typeof payload === 'string' ? payload : JSON.stringify(payload);
    return crypto.createHash('sha256').update(`${topic}|${body}`).digest('hex');
  } catch {
    return crypto.randomUUID();
  }
}

async function writeDataToFirestore(machineId, payload, raw) {
  // Expect payload to include ts (ms or ISO). If missing, use server time.
  const ts = Number(payload.ts) || Date.now();
  const date = new Date(ts);
  const y = date.getUTCFullYear();
  const m = String(date.getUTCMonth() + 1).padStart(2, '0');
  const d = String(date.getUTCDate()).padStart(2, '0');

  // Machines collection
  const machineRef = db.collection('machines').doc(machineId);
  await machineRef.set({
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });

  // Use deterministic doc ID for idempotency
  const docId = String(ts);
  const logRef = machineRef.collection('logs').doc(`${y}-${m}-${d}`).collection('entries').doc(docId);

  // Create if not exists to be idempotent
  await logRef.create({
    machineId,
    ts,
    data: payload,
    raw,
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  }).catch(err => {
    if (err.code === 6 /* ALREADY_EXISTS */) {
      logger.debug({ machineId, ts }, 'Duplicate data ignored');
    } else {
      throw err;
    }
  });
}

async function writeStatusToFirestore(machineId, payload) {
  const machineRef = db.collection('machines').doc(machineId);
  await machineRef.set({
    status: payload,
    statusUpdatedAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
}

async function writeAlertToFirestoreAndNotify(machineId, payload) {
  const ts = Number(payload.ts) || Date.now();
  const date = new Date(ts);
  const y = date.getUTCFullYear();
  const m = String(date.getUTCMonth() + 1).padStart(2, '0');
  const d = String(date.getUTCDate()).padStart(2, '0');

  const machineRef = db.collection('machines').doc(machineId);
  const alertRef = machineRef.collection('alerts').doc(`${y}-${m}-${d}`).collection('entries').doc(String(ts));

  await alertRef.create({
    machineId,
    ts,
    type: payload.type,
    severity: payload.severity || 'critical',
    message: payload.message || '',
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  }).catch(err => {
    if (err.code === 6) {
      logger.debug({ machineId, ts }, 'Duplicate alert ignored');
    } else {
      throw err;
    }
  });

  // Send FCM to owner(s)
  const machineSnap = await machineRef.get();
  const ownerId = machineSnap.exists ? machineSnap.data().ownerId : null;
  if (!ownerId) return; // no owner bound

  // Collect tokens from users/{uid}/fcmTokens/* with field token
  const tokensSnap = await db.collection('users').doc(ownerId).collection('fcmTokens').get();
  const tokens = tokensSnap.docs.map(d => d.data().token).filter(Boolean);
  if (!tokens.length) return;

  const fcmPayload = {
    notification: {
      title: `EaseMilker: ${payload.type}`,
      body: payload.message || `Machine ${machineId} alert: ${payload.type}`
    },
    data: {
      machineId,
      type: payload.type || 'ALERT',
      ts: String(ts)
    }
  };
  const chunkSize = 450; // safety margin below 500 tokens
  for (let i = 0; i < tokens.length; i += chunkSize) {
    const chunk = tokens.slice(i, i + chunkSize);
    await messaging.sendEachForMulticast({ ...fcmPayload, tokens: chunk });
  }
}

function parseTopic(topic) {
  // easemilker/{machineId}/{type}
  const parts = topic.split('/');
  if (parts.length !== 3) return null;
  return { machineId: parts[1], type: parts[2] };
}

async function handleMessage(topic, message) {
  const parsed = parseTopic(topic);
  if (!parsed) return;

  let payload;
  try {
    payload = JSON.parse(message.toString());
  } catch (e) {
    logger.warn({ topic, err: e }, 'Invalid JSON payload');
    return;
  }

  const msgId = payload.msgId || computeMessageId(topic, payload);
  if (seenMessageIds.has(msgId)) return;
  seenMessageIds.add(msgId);

  try {
    if (parsed.type === 'data') {
      await writeDataToFirestore(parsed.machineId, payload, message.toString());
    } else if (parsed.type === 'status') {
      await writeStatusToFirestore(parsed.machineId, payload);
    } else if (parsed.type === 'alert') {
      await writeAlertToFirestoreAndNotify(parsed.machineId, payload);
    }
    logger.info({ topic, msgId }, 'Message processed');
  } catch (err) {
    logger.error({ topic, err }, 'Failed to process message');
  }
}

function startMqttIngestion() {
  if (!MQTT_BROKER_URL) return;

  let attempt = 0;
  const maxDelay = 30_000;

  function connect() {
    attempt++;
    const delay = Math.min(1000 * 2 ** Math.min(attempt, 5), maxDelay);
    logger.info({ attempt }, 'Connecting to MQTT...');

    const client = mqtt.connect(MQTT_BROKER_URL, mqttOptions);

    client.on('connect', () => {
      attempt = 0;
      logger.info('MQTT connected');
      client.subscribe(SUB_TOPICS, { qos: 1 }, (err) => {
        if (err) logger.error({ err }, 'Subscribe failed');
        else logger.info({ topics: SUB_TOPICS }, 'Subscribed');
      });
    });

    client.on('message', (topic, message) => {
      handleMessage(topic, message).catch((e) => logger.error({ e }, 'handleMessage error'));
    });

    client.on('error', (err) => {
      logger.error({ err }, 'MQTT error');
    });

    client.on('close', () => {
      logger.warn('MQTT connection closed');
      setTimeout(connect, Math.random() * delay);
    });

    client.on('reconnect', () => {
      logger.warn('MQTT reconnecting...');
    });

    client.on('end', () => {
      logger.warn('MQTT ended');
    });
  }

  connect();
}

// -------- Express API (for onboarding and queries) ---------
const app = express();
app.use(cors());
app.use(express.json());

async function verifyIdToken(req, res, next) {
  const authz = req.headers.authorization || '';
  const token = authz.startsWith('Bearer ') ? authz.slice(7) : null;
  if (!token) return res.status(401).json({ error: 'Missing Bearer token' });
  try {
    const decoded = await auth.verifyIdToken(token);
    req.user = decoded;
    next();
  } catch (e) {
    return res.status(401).json({ error: 'Invalid token' });
  }
}

// POST /api/machines/register { machineId }
app.post('/api/machines/register', verifyIdToken, async (req, res) => {
  const uid = req.user.uid;
  const { machineId } = req.body || {};
  if (!machineId) return res.status(400).json({ error: 'machineId required' });

  const machineRef = db.collection('machines').doc(machineId);
  const snap = await machineRef.get();
  if (snap.exists && snap.data().ownerId && snap.data().ownerId !== uid) {
    return res.status(409).json({ error: 'Machine already owned' });
  }

  await machineRef.set({ ownerId: uid, boundAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });
  return res.json({ ok: true, machineId });
});

// POST /api/machines/unbind { machineId }
app.post('/api/machines/unbind', verifyIdToken, async (req, res) => {
  const uid = req.user.uid;
  const { machineId } = req.body || {};
  if (!machineId) return res.status(400).json({ error: 'machineId required' });

  const machineRef = db.collection('machines').doc(machineId);
  const snap = await machineRef.get();
  if (!snap.exists || snap.data().ownerId !== uid) return res.status(404).json({ error: 'Not found' });

  await machineRef.set({ ownerId: admin.firestore.FieldValue.delete() }, { merge: true });
  return res.json({ ok: true });
});

// GET /api/machines
app.get('/api/machines', verifyIdToken, async (req, res) => {
  const uid = req.user.uid;
  const q = await db.collection('machines').where('ownerId', '==', uid).get();
  const machines = q.docs.map(d => ({ id: d.id, ...d.data() }));
  return res.json({ machines });
});

// GET /api/logs?machineId=...&period=daily|weekly|monthly&date=YYYY-MM-DD
app.get('/api/logs', verifyIdToken, async (req, res) => {
  const uid = req.user.uid;
  const { machineId, period = 'daily', date } = req.query;
  if (!machineId) return res.status(400).json({ error: 'machineId required' });
  const machineRef = db.collection('machines').doc(String(machineId));
  const snap = await machineRef.get();
  if (!snap.exists || snap.data().ownerId !== uid) return res.status(404).json({ error: 'Not found' });

  let targetDate = date ? new Date(date) : new Date();
  if (isNaN(targetDate.getTime())) return res.status(400).json({ error: 'Invalid date' });
  const y = targetDate.getUTCFullYear();
  const m = String(targetDate.getUTCMonth() + 1).padStart(2, '0');
  const d = String(targetDate.getUTCDate()).padStart(2, '0');

  if (period === 'daily') {
    const dayDoc = await machineRef.collection('logs').doc(`${y}-${m}-${d}`).get();
    const entriesSnap = await machineRef.collection('logs').doc(`${y}-${m}-${d}`).collection('entries').orderBy('ts', 'asc').get();
    return res.json({ summary: dayDoc.data() || null, entries: entriesSnap.docs.map(x => x.data()) });
  }
  if (period === 'weekly' || period === 'monthly') {
    const summaryRef = machineRef.collection('summaries').doc(period).collection('entries').doc(`${y}-${m}-${d}`);
    const summarySnap = await summaryRef.get();
    return res.json({ summary: summarySnap.data() || null });
  }
  return res.status(400).json({ error: 'Invalid period' });
});

const port = Number(process.env.PORT || 8080);
app.listen(port, () => logger.info({ port }, 'API server started'));

// Start MQTT ingestion after server starts
startMqttIngestion();

// -------- Scheduled Aggregation (to run in Cloud Functions/Run via scheduler) ---------
// Expose an HTTP endpoint for aggregation (Cloud Scheduler can invoke with OIDC)
app.post('/internal/aggregate/daily', async (req, res) => {
  try {
    const since = new Date();
    since.setUTCDate(since.getUTCDate() - 1); // yesterday
    const y = since.getUTCFullYear();
    const m = String(since.getUTCMonth() + 1).padStart(2, '0');
    const d = String(since.getUTCDate()).padStart(2, '0');

    const machinesSnap = await db.collection('machines').get();
    const limit = pLimit(5);
    const tasks = machinesSnap.docs.map(doc => limit(() => aggregateDayForMachine(doc.id, `${y}-${m}-${d}`)));
    await Promise.all(tasks);
    res.json({ ok: true, date: `${y}-${m}-${d}` });
  } catch (e) {
    logger.error({ err: e }, 'Daily aggregation failed');
    res.status(500).json({ error: 'aggregation failed' });
  }
});

async function aggregateDayForMachine(machineId, dayKey) {
  const entriesSnap = await db.collection('machines').doc(machineId).collection('logs').doc(dayKey).collection('entries').get();
  let totalVolumeMl = 0;
  let count = 0;
  let maxTemp = null;
  entriesSnap.forEach(doc => {
    const e = doc.data();
    if (e?.data?.volume_ml != null) totalVolumeMl = Math.max(totalVolumeMl, e.data.volume_ml);
    if (e?.data?.temp_c != null) maxTemp = maxTemp == null ? e.data.temp_c : Math.max(maxTemp, e.data.temp_c);
    count++;
  });
  await db.collection('machines').doc(machineId).collection('logs').doc(dayKey).set({
    summary: {
      totalVolumeMl,
      maxTemp,
      entries: count
    },
    aggregatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
}
