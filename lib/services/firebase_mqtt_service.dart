import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:logger/logger.dart';

class FirebaseMqttService {
  FirebaseMqttService._();
  static final FirebaseMqttService instance = FirebaseMqttService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  MqttServerClient? _client;
  StreamSubscription? _mqttSub;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _firestoreSub;

  String? _machineId;
  String _telemetryTopic = '';
  String _commandPowerTopic = '';

  DateTime _lastUpdate = DateTime.fromMillisecondsSinceEpoch(0);
  Timer? _throttleTimer;
  String? _pendingPayload;

  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();
  final StreamController<bool> _powerController = StreamController<bool>.broadcast();
  final StreamController<bool> _milkingController = StreamController<bool>.broadcast();
  final StreamController<double> _todayLitresController = StreamController<double>.broadcast();
  final StreamController<double> _liveFlowLitresController = StreamController<double>.broadcast();

  Stream<bool> get connected$ => _connectionController.stream;
  Stream<bool> get powerOn$ => _powerController.stream;
  Stream<bool> get milking$ => _milkingController.stream;
  Stream<double> get todayLitres$ => _todayLitresController.stream;
  Stream<double> get liveFlowLitres$ => _liveFlowLitresController.stream;

  Future<void> disconnect() async {
    try {
      await _mqttSub?.cancel();
      await _firestoreSub?.cancel();
      _mqttSub = null;
      _firestoreSub = null;

      if (_client != null &&
          _client!.connectionStatus?.state == MqttConnectionState.connected) {
        _client!.disconnect();
      }
    } finally {
      _client = null;
      if (_machineId != null) {
        await _updateFirestoreState(isConnected: false);
      }
      _connectionController.add(false);
    }
  }

  Future<bool> connectWithMachineId(String machineId) async {
    _machineId = machineId;

    // Ensure Firebase authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "testuser@gmail.com",
          password: "Test@1234", // Update this with your actual password
        );
        user = FirebaseAuth.instance.currentUser;
        _logger.i("Signed in as ${user?.uid}");
      } catch (e) {
        _logger.e("Firebase Auth failed: $e");
        return false;
      }
    }

    // Validate machine ownership
    final docRef = _db.collection('machines').doc(machineId);
    final doc = await docRef.get();

    if (!doc.exists) {
      _logger.w("Machine ID not found in Firestore.");
      return false;
    }

    final data = doc.data() ?? {};
    final ownerId = data['ownerId'];
    if (ownerId != user!.uid) {
      _logger.w("Access denied: Machine is owned by another user.");
      return false;
    }

    // MQTT config
    final broker = (data['mqttBroker'] as String?) ?? 'broker.hivemq.com';
    final port = (data['mqttPort'] as int?) ?? 1883;
    final username = (data['mqttUsername'] as String?) ?? '';
    final password = (data['mqttPassword'] as String?) ?? '';
    final useTls = (data['mqttUseTls'] as bool?) ?? false;
    final baseTopic = (data['baseTopic'] as String?) ?? 'easemilker';

    _telemetryTopic = '$baseTopic/$machineId/telemetry';
    _commandPowerTopic = '$baseTopic/$machineId/command/power';

    _listenToFirestore(machineId);

    // FOR TESTING: Skip MQTT connection if broker is default/public or in dev mode
    // Set to false when you're ready to test with the real broker
    const devMode = true; // Change to false for production MQTT
    final isTestMode = devMode || broker == 'broker.hivemq.com' || broker.isEmpty;
    
    if (isTestMode) {
      _logger.w("⚠️ TEST MODE: Bypassing MQTT connection (devMode=$devMode, broker=$broker)");
      _connectionController.add(true);
      await _updateFirestoreState(isConnected: true);
      return true;
    }

    final ok = await _connectMqtt(
      broker: broker,
      port: port,
      username: username.isEmpty ? null : username,
      password: password.isEmpty ? null : password,
      useTls: useTls,
      clientId: 'easemilker_app_${DateTime.now().millisecondsSinceEpoch}',
    );

    if (ok) {
      _logger.i("MQTT Connected Successfully");
      _connectionController.add(true);
      await _updateFirestoreState(isConnected: true);
      _subscribeTelemetry();
    } else {
      _logger.e("MQTT Connection Failed");
      _connectionController.add(false);
      await _updateFirestoreState(isConnected: false);
    }

    return ok;
  }

  Future<bool> _connectMqtt({
    required String broker,
    required int port,
    String? username,
    String? password,
    bool useTls = false,
    required String clientId,
  }) async {
    await _mqttSub?.cancel();
    _mqttSub = null;

    final client = MqttServerClient.withPort(broker, clientId, port);
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = true;
    client.secure = useTls;
    
    // Configure TLS context for secure connections
    if (useTls) {
      client.securityContext = SecurityContext.defaultContext;
    }
    client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    try {
      _logger.i("Attempting MQTT connection to $broker:$port (TLS: $useTls)");
      if (username != null && password != null && username.isNotEmpty) {
        _logger.i("Using authentication (username: $username)");
        await client.connect(username, password).timeout(const Duration(seconds: 10));
      } else {
        _logger.i("Connecting without authentication");
        await client.connect().timeout(const Duration(seconds: 10));
      }

      if (client.connectionStatus?.state == MqttConnectionState.connected) {
        _logger.i("✅ MQTT Connected successfully!");
        _client = client;
        return true;
      } else {
        _logger.w("Connection status: ${client.connectionStatus?.state}");
      }
    } catch (e) {
      _logger.e("MQTT connect error: $e");
      client.disconnect();
    }
    return false;
  }

  void _onConnected() {
    _connectionController.add(true);
    _subscribeTelemetry();
  }

  void _onDisconnected() {
    _connectionController.add(false);
    _updateFirestoreState(isConnected: false);
  }

  void _subscribeTelemetry() {
    if (_client == null ||
        _client!.connectionStatus?.state != MqttConnectionState.connected) {
      return;
    }

    unawaited(_mqttSub?.cancel());
    _mqttSub = null;
    _client!.subscribe(_telemetryTopic, MqttQos.atLeastOnce);
    _mqttSub = _client!.updates!.listen((events) {
      for (final e in events) {
        final rec = e.payload as MqttPublishMessage;
        final payloadString =
            MqttPublishPayload.bytesToStringAsString(rec.payload.message);
        _handleTelemetry(payloadString);
      }
    });
  }

  void _handleTelemetry(String payload) {
    final now = DateTime.now();
    final elapsed = now.difference(_lastUpdate);
    if (elapsed < const Duration(seconds: 1)) {
      _pendingPayload = payload;
      _throttleTimer ??= Timer(const Duration(seconds: 1), () async {
        final p = _pendingPayload;
        _pendingPayload = null;
        _throttleTimer = null;
        if (p != null) {
          _lastUpdate = DateTime.now();
          await _processTelemetry(p);
        }
      });
      return;
    }

    _lastUpdate = now;
    unawaited(_processTelemetry(payload));
  }

  Future<void> _processTelemetry(String payload) async {
    double? flowLps;
    double? totalL;
    bool? isMilking;

    try {
      final map = jsonDecode(payload);
      if (map is Map<String, dynamic>) {
        flowLps = (map['flow_lps'] as num?)?.toDouble();
        totalL = (map['total_l'] as num?)?.toDouble();
        final milkingAny = map['isMilking'];
        if (milkingAny is bool) {
          isMilking = milkingAny;
        } else if (milkingAny is num) {
          isMilking = milkingAny != 0;
        }
      }
    } catch (_) {
      final parts = payload.split(',');
      if (parts.length >= 3) {
        flowLps = double.tryParse(parts[0]);
        totalL = double.tryParse(parts[1]);
        isMilking = parts[2].trim() == '1' || parts[2].trim().toLowerCase() == 'true';
      }
    }

    if (flowLps != null) {
      _liveFlowLitresController.add(flowLps);
      await _updateFirestoreState(milkFlowLitres: flowLps);
    }
    if (totalL != null) {
      _todayLitresController.add(totalL);
      await _updateFirestoreState(totalMilkLitres: totalL);
    }
    if (isMilking != null) {
      _milkingController.add(isMilking);
      await _updateFirestoreState(isMilking: isMilking);
    }
  }

  Future<void> sendPowerCommand(bool turnOn) async {
    if (_client == null ||
        _client!.connectionStatus?.state != MqttConnectionState.connected) {
      return;
    }

    final payload = turnOn ? 'ON' : 'OFF';
    final builder = MqttClientPayloadBuilder()..addString(payload);
    _client!.publishMessage(_commandPowerTopic, MqttQos.atLeastOnce, builder.payload!);
    _powerController.add(turnOn);
    await _updateFirestoreState(isOn: turnOn);
  }

  void _listenToFirestore(String machineId) {
    unawaited(_firestoreSub?.cancel());
    _firestoreSub = _db.collection('machines').doc(machineId).snapshots().listen((snap) {
      if (!snap.exists) {
        return;
      }
      final data = snap.data() ?? {};
      _powerController.add((data['isOn'] as bool?) ?? false);
      _milkingController.add((data['isMilking'] as bool?) ?? false);
      final flow = (data['milkFlowLitres'] as num?)?.toDouble();
      final total = (data['totalMilkLitres'] as num?)?.toDouble();
      final status = (data['connectionStatus'] as String?) ?? 'Disconnected';
      if (flow != null) {
        _liveFlowLitresController.add(flow);
      }
      if (total != null) {
        _todayLitresController.add(total);
      }
      _connectionController.add(status == 'Connected');
    });
  }

  Future<void> _updateFirestoreState({
    bool? isConnected,
    bool? isOn,
    bool? isMilking,
    double? milkFlowLitres,
    double? totalMilkLitres,
  }) async {
    if (_machineId == null) {
      return;
    }

    final update = <String, Object?>{
      if (isConnected != null)
        'connectionStatus': isConnected ? 'Connected' : 'Disconnected',
      if (isOn != null) 'isOn': isOn,
      if (isMilking != null) 'isMilking': isMilking,
      if (milkFlowLitres != null) 'milkFlowLitres': milkFlowLitres,
      if (totalMilkLitres != null) 'totalMilkLitres': totalMilkLitres,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (update.isEmpty) {
      return;
    }

    await _db.collection('machines').doc(_machineId!).set(update, SetOptions(merge: true));
  }

  Future<void> refresh() async {}
}
