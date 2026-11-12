import 'max_pressure_config.dart';

class PatientAlarmSettings {
  final bool maxPressureEnabled;

  final Map<int, MaxPressureConfig>
  sensorConfigs;

  const PatientAlarmSettings({
    required this.maxPressureEnabled,
    required this.sensorConfigs,
  });

  Map<String, dynamic> toMap() {
    return {
      'maxPressureEnabled':
      maxPressureEnabled,

      'sensorConfigs':
      sensorConfigs.map(
            (key, value) => MapEntry(
          key.toString(),
          value.toMap(),
        ),
      ),
    };
  }

  factory PatientAlarmSettings.fromMap(
      Map<String, dynamic> map,
      ) {
    final configs =
    (map['sensorConfigs']
    as Map<String, dynamic>? ??
        {});

    return PatientAlarmSettings(
      maxPressureEnabled:
      map['maxPressureEnabled'] ?? false,

      sensorConfigs:
      configs.map(
            (key, value) => MapEntry(
          int.parse(key),
          MaxPressureConfig.fromMap(
              value),
        ),
      ),
    );
  }

  static PatientAlarmSettings defaults() {
    return PatientAlarmSettings(
      maxPressureEnabled: false,

      sensorConfigs: {
        for (int i = 1; i <= 36; i++)
          i: const MaxPressureConfig(
            enabled: true,
            threshold: 1.0,
            framesRequired: 5,
          ),
      },
    );
  }

}

