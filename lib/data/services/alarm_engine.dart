import '/models/sensor_readings.dart';
import '/models/alarms.dart';
import '/models/alarm_definition.dart';
import '/models/alarm_override.dart';
import '../repositories/alarm_definition_repository.dart';
import '../repositories/alarm_override_repository.dart';
import '../repositories/alarm_repository.dart';

class AlarmEngine {
  final AlarmDefinitionRepository definitionRepo;
  final AlarmOverrideRepository overrideRepo;
  final AlarmRepository alarmRepo;

  // slidingWindows[alarmType][sensorNumber] = List<double>
  final Map<String, Map<int, List<double>>> slidingWindows = {};

  AlarmEngine({
    required this.definitionRepo,
    required this.overrideRepo,
    required this.alarmRepo,
  });

  Future<void> evaluateReading(
      SensorReading reading,
      String patientId,
      String sessionId,
      ) async {
    final defs = await definitionRepo.getAllDefinitions();

    for (final def in defs) {
      if (!def.enabled) continue;

      // Load patient override (if any)
      final override = await overrideRepo.getOverride(patientId, def.type);
      final threshold = override?.threshold ?? def.defaultThreshold;

      // Prepare sliding window for this alarm + sensor
      slidingWindows.putIfAbsent(def.type, () => {});
      final sensorWindows = slidingWindows[def.type]!;
      final window = sensorWindows.putIfAbsent(reading.sensorNumber, () => []);

      // Add new values
      window.addAll(reading.values);

      // Trim window
      while (window.length > def.windowSize) {
        window.removeAt(0);
      }

      bool shouldTrigger = false;

      // -------------------------
      // ALGORITHM: THRESHOLD
      // -------------------------
      if (def.algorithm == "threshold") {
        if (threshold == null) continue;

        final count = window.where((v) => v >= threshold).length;
        shouldTrigger = count >= def.triggerCount;
      }

      // -------------------------
      // ALGORITHM: NO PRESSURE (bed exit)
      // -------------------------
      else if (def.algorithm == "no_pressure") {
        if (threshold == null) continue;

        final count = window.where((v) => v < threshold).length;
        shouldTrigger = count >= def.triggerCount;
      }

      // -------------------------
      // ALGORITHM: MOVEMENT
      // -------------------------
      else if (def.algorithm == "movement") {
        if (threshold == null) continue;

        final diffs = <double>[];
        for (int i = 1; i < window.length; i++) {
          diffs.add((window[i] - window[i - 1]).abs());
        }

        final count = diffs.where((d) => d >= threshold).length;
        shouldTrigger = count >= def.triggerCount;
      }

      // -------------------------
      // TRIGGER ALARM
      // -------------------------
      if (shouldTrigger) {
        final alarm = Alarm(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          timestamp: DateTime.now(),
          type: def.type,
          details: def.description,
          acknowledged: false,
          sensorNumber: reading.sensorNumber,
          value: window.isNotEmpty ? window.last : 0.0,
        );

        await alarmRepo.saveAlarm(patientId, sessionId, alarm);
      }
    }
  }
}
