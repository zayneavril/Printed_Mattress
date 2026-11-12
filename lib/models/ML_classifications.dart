class PositionClassification {
  final String id;
  final String patientId;
  final String sensorReadingId;
  final DateTime timestamp;
  final String position;
  final double confidence;

  PositionClassification({
    required this.id,
    required this.patientId,
    required this.sensorReadingId,
    required this.timestamp,
    required this.position,
    required this.confidence,
  });
}
