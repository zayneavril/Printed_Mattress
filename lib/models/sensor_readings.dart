// class SensorReading {
//   final String id;
//   final DateTime timestamp;
//   final int sensorNumber;
//   final List<double> values;
//
//   SensorReading({
//     required this.id,
//     required this.timestamp,
//     required this.sensorNumber,
//     required this.values,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'timestamp': timestamp.toIso8601String(),
//       'sensorNumber': sensorNumber,
//       'values': values,
//     };
//   }
//
//   factory SensorReading.fromMap(String id, Map<String, dynamic> map) {
//     return SensorReading(
//       id: id,
//       timestamp: DateTime.parse(map['timestamp']),
//       sensorNumber: map['sensorNumber'],
//       values: List<double>.from(map['values'].map((v) => (v as num).toDouble())),
//     );
//   }
// }

class SensorReading {
  final String id;
  final DateTime timestamp;
  final int sensorNumber;
  final List<double> values;

  SensorReading({
    required this.id,
    required this.timestamp,
    required this.sensorNumber,
    required this.values,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'sensorNumber': sensorNumber,
      'values': values,
    };
  }

  factory SensorReading.fromMap(Map<String, dynamic> map) {
    return SensorReading(
      id: map['id'],
      timestamp: DateTime.parse(map['timestamp']),
      sensorNumber: map['sensorNumber'],
      values: List<double>.from(
        (map['values'] as List).map((v) => (v as num).toDouble()),
      ),
    );
  }
}
