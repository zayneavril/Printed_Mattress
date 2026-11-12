class Alarm {
  final String id;
  final DateTime timestamp;
  final String type;          // e.g. "high_pressure"
  final String details;       // human-readable message
  final bool acknowledged;
  final int sensorNumber;     // which sensor triggered it
  final double value;         // value that caused the alarm

  Alarm({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.details,
    required this.acknowledged,
    required this.sensorNumber,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'type': type,
      'details': details,
      'acknowledged': acknowledged,
      'sensorNumber': sensorNumber,
      'value': value,
    };
  }

  factory Alarm.fromMap(String id, Map<String, dynamic> map) {
    return Alarm(
      id: id,
      timestamp: DateTime.parse(map['timestamp']),
      type: map['type'],
      details: map['details'],
      acknowledged: map['acknowledged'],
      sensorNumber: map['sensorNumber'],
      value: (map['value'] as num).toDouble(),
    );
  }
}

