import '/../models/alarms.dart';
import '/../models/patient_alarm_settings.dart';

class MaxPressureAlarmService {

  final Set<int> _activeSensors = {};

  Alarm? evaluate({
    required List<List<double>> frameHistory,
    required PatientAlarmSettings settings,
  }) {

    if (!settings.maxPressureEnabled) {
      return null;
    }

    for (int sensor = 1; sensor <= 210; sensor++) {

      final config =
      settings.sensorConfigs[sensor];

      if (config == null) {
        continue;
      }

      if (!config.enabled) {
        continue;
      }

      final framesRequired =
          config.framesRequired;

      final threshold =
          config.threshold;

      if (frameHistory.length <
          framesRequired) {
        continue;
      }

      final recentFrames =
      frameHistory.sublist(
        frameHistory.length - framesRequired,
      );

      bool exceeded = true;

      for (final frame in recentFrames) {

        if (frame[sensor - 1] <
            threshold) {

          exceeded = false;

          break;
        }
      }

      // Sensor has recovered
      if (!exceeded) {

        _activeSensors.remove(sensor);

        continue;
      }

      // Already alarming
      if (_activeSensors.contains(sensor)) {
        continue;
      }

      _activeSensors.add(sensor);

      return Alarm(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),

        timestamp: DateTime.now(),

        type: 'max_pressure',

        details:
        'Sensor $sensor exceeded '
            'threshold $threshold for '
            '$framesRequired frames',

        acknowledged: false,

        sensorNumber: sensor,

        value: recentFrames.last[
        sensor - 1],
      );
    }

    return null;
  }
}