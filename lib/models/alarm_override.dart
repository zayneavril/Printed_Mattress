class AlarmOverride {
  final String alarmType;
  final double threshold;

  AlarmOverride({
    required this.alarmType,
    required this.threshold,
  });

  Map<String, dynamic> toMap() {
    return {
      'threshold': threshold,
    };
  }

  factory AlarmOverride.fromMap(String alarmType, Map<String, dynamic> map) {
    return AlarmOverride(
      alarmType: alarmType,
      threshold: (map['threshold'] as num).toDouble(),
    );
  }
}
