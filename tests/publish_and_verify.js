// tests/publish_and_verify.js
// Simple acceptance test: publish MQTT messages and verify Firestore write
require('dotenv').config({ path: '../functions/.env' });
const mqtt = require('mqtt');
const admin = require('firebase-admin');

if (!admin.apps.length) {
  admin.initializeApp({ projectId: process.env.FIREBASE_PROJECT_ID });
}
const db = admin.firestore();

async function main() {
  const machineId = process.env.TEST_MACHINE_ID || 'TEST_MACHINE_001';
  const now = Date.now();
  const data = { ts: now, volume_ml: 123, temp_c: 36.5, flow_lpm: 1.2 };
  const status = { ts: now, state: 'RUNNING' };
  const alert = { ts: now, type: 'NO_FLOW', message: 'Flow stopped' };

  const client = mqtt.connect(process.env.MQTT_BROKER_URL, {
    username: process.env.MQTT_USERNAME,
    password: process.env.MQTT_PASSWORD,
    clean: true
  });

  await new Promise((resolve, reject) => {
    client.on('connect', resolve);
    client.on('error', reject);
    setTimeout(() => reject(new Error('MQTT connect timeout')), 10000);
  });

  client.publish(`easemilker/${machineId}/data`, JSON.stringify(data), { qos: 1 });
  client.publish(`easemilker/${machineId}/status`, JSON.stringify(status), { qos: 1 });
  client.publish(`easemilker/${machineId}/alert`, JSON.stringify(alert), { qos: 1 });

  // wait for ingestion
  await new Promise(r => setTimeout(r, 4000));

  const date = new Date(now);
  const dayKey = `${date.getUTCFullYear()}-${String(date.getUTCMonth() + 1).padStart(2, '0')}-${String(date.getUTCDate()).padStart(2, '0')}`;
  const entryRef = db.collection('machines').doc(machineId).collection('logs').doc(dayKey).collection('entries').doc(String(now));
  const snap = await entryRef.get();
  if (!snap.exists) {
    console.error('Log entry not found');
    process.exit(2);
  }
  console.log('Success: Firestore entry created');
  process.exit(0);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
