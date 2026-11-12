import 'dart:async';
import 'dart:convert';
import 'package:riverpod/riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/services/mqtt_service.dart';
import '../models/sensor_readings.dart';
import '../data/utils/topic_parser.dart';
import '../state/monitoring_session_provider.dart';
import 'firestore_repository_provider.dart';
import 'alarm_engine_provider.dart';
part 'mqtt_providers.g.dart';

class MqttStreamBridge {
  final MqttService service;
  final Ref ref;
  final _controller = StreamController<SensorReading>.broadcast();

  Stream<SensorReading> get stream => _controller.stream;

  MqttStreamBridge(this.service, this.ref);

  Future<void> handleMessage({
    required String topic,
    required String payload,
  }) async {
    // 1. Backend logic (NO patient/session here)
    await service.handleIncomingMessage(
      topic: topic,
      payload: payload,
    );

    // 2. Parse topic
    final parsed = TopicParser.parse(topic);
    if (parsed == null) return;

    // 3. Decode payload
    final data = jsonDecode(payload);
    final timestamp = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
    final value = (data['value'] as num).toDouble();

    final reading = SensorReading(
      id: timestamp.millisecondsSinceEpoch.toString(),
      timestamp: timestamp,
      sensorNumber: parsed.sensorNumber,
      values: [value],
    );

    // 4. Push to UI stream
    _controller.add(reading);

  //   // 5. Save to Firestore using ACTIVE SESSION
  //   final session = ref.read(monitoringSessionControllerProvider);
  //
  //   if (session != null) {
  //     final repo = ref.read(firestoreRepositoryProvider);
  //     await repo.saveReading(
  //       session.patientId,
  //       session.sessionId,
  //       reading,
  //     );
  //   }
  }

  void dispose() {
    //_controller.close();
  }
}

@riverpod
MqttService mqttService(Ref ref) {
  final firestore = ref.read(firestoreRepositoryProvider);
  final alarmEngine = ref.read(alarmEngineProvider);

  return MqttService(
    alarmEngine: alarmEngine,
    firestore: firestore,
    ref: ref,
  );
}

@riverpod
MqttStreamBridge mqttBridge(Ref ref) {
  final service = ref.watch(mqttServiceProvider);
  final bridge = MqttStreamBridge(service, ref);
  ref.onDispose(bridge.dispose);
  return bridge;
}

@riverpod
Stream<SensorReading> mqttReadings(Ref ref) {
  final bridge = ref.watch(mqttBridgeProvider);
  return bridge.stream;
}
