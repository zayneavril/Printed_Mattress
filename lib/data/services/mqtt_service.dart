import 'dart:convert';
import 'package:first_app/data/repositories/alarm_definition_repository_impl.dart';

import '../utils/topic_parser.dart';
import '/../models/sensor_readings.dart';
import '../repositories/firestore_repository.dart';
import '../services/alarm_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/../state/monitoring_session_provider.dart';
import '/../state/monitoring_providers.dart';
import '../services/frame_builder.dart';
import '/../state/classification_providers.dart';
import '../services/normalisation_service.dart';
import '../services/max_pressure_alarm_service.dart';
import '../services/firestore_service.dart';
import '../repositories/alarm_repository_impl.dart';
import '/../state/alarm_providers.dart';
import '/../state/patient_providers.dart';

class MqttService {
  final AlarmEngine alarmEngine;
  final FirestoreRepository firestore;
  final Ref ref;
  final MaxPressureAlarmService
  _maxPressureAlarmService = MaxPressureAlarmService();
  final AlarmRepositoryImpl _alarmRepositoryImpl = AlarmRepositoryImpl(
    FirestoreService(),);

  MqttService({
    required this.alarmEngine,
    required this.firestore,
    required this.ref,
  });


  Future<void> handleIncomingMessage({
    required String topic,
    required String payload,
  }) async {
    // 1. Parse topic
    final parsed = TopicParser.parse(topic);
    if (parsed == null) return;

    final sensorNumber = parsed.sensorNumber;

    if (sensorNumber == 210) {
      print('Sensor 210 received');
    }

    // 2. Decode JSON
    final data = jsonDecode(payload);
    final value = (data['value'] as num).toDouble();

    // 3. Build SensorReading
    final reading = SensorReading(
      id: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      timestamp: DateTime.now(),
      sensorNumber: sensorNumber,
      values: [value],
    );

    ref
        .read(latestSensorValuesProvider.notifier)
        .update(reading);

    // Build a full mattress frame every time sensor 210 arrives
    if (sensorNumber == 210) {
      final latestValues =
      ref.read(latestSensorValuesProvider);

      final frame =
      FrameBuilder.buildFrame(latestValues);

      final baseline =
      ref.read(baselineFrameProvider);

      if (baseline != null) {
        final normalised =
        NormalisationService.normalise(
          frame: frame,
          baseline: baseline,
        );

        ref
            .read(frameHistoryProvider.notifier)
            .addFrame(normalised);

        final history =
        ref.read(frameHistoryProvider);

        final activePatient =
        ref.read(activePatientProvider);

        final session =
        ref.read(
          monitoringSessionControllerProvider,
        );

        if (activePatient != null &&
            session != null) {
          final settings =
              ref
                  .read(
                activePatientAlarmSettingsProvider,
              )
                  .value;

          if (settings != null) {
            final alarm =
            _maxPressureAlarmService.evaluate(
              frameHistory: history,
              settings: settings,
            );

            if (alarm != null) {
              await _alarmRepositoryImpl.saveAlarm(
                activePatient.id,
                session.sessionId,
                alarm,
              );

              ref
                  .read(
                activeAlarmsProvider.notifier,
              )
                  .add(alarm);
            }
          }

          print(
            'Frame length: ${frame.length}',
          );
        }
      }
    }


    // Capture complete mattress frame during calibration
    if (
    ref.read(calibrationRunningProvider) &&
        sensorNumber == 210
    ) {
      print('=== CALIBRATION FRAME CAPTURE ===');

      final latestValues =
      ref.read(latestSensorValuesProvider);

      print(
        'Values in map: ${latestValues.length}',
      );

      final frame =
      FrameBuilder.buildFrame(
        latestValues,
      );
      final baseline =
      ref.read(baselineFrameProvider);

      // if (baseline != null) {
      //   final normalised =
      //   NormalisationService.normalise(
      //     frame: frame,
      //     baseline: baseline,
      //   );
      //
      //   ref
      //       .read(
      //     frameHistoryProvider.notifier,
      //   )
      //       .addFrame(normalised);
      // }

      print(
        'Frame length: ${frame.length}',
      );

      ref
          .read(
        calibrationFramesProvider.notifier,
      )
          .addFrame(frame);

      print(
        'Stored frames: '
            '${ref.read(calibrationFramesProvider).length}',
      );
    }


    if (
    ref.read(classificationRunningProvider) &&
        sensorNumber == 210
    ) {
      final latestValues =
      ref.read(latestSensorValuesProvider);

      final frame =
      FrameBuilder.buildFrame(latestValues);

      ref
          .read(
        classificationFramesProvider.notifier,
      )
          .addFrame(frame);
    }


    ref
        .read(slidingWindowProvider.notifier)
        .add(reading);

    // ✅ ONLY save to Firestore if monitoring is active
    final session = ref.read(monitoringSessionControllerProvider);
    if (session != null && session.endTime == null) {
      await firestore.saveSensorReading(
        patientId: session.patientId,
        sessionId: session.sessionId,
        sensorNumber: sensorNumber,
        value: value,
      );

      await alarmEngine.evaluateReading(
        reading,
        session.patientId,
        session.sessionId,
      );
    }
  }
}


