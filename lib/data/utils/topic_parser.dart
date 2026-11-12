class TopicParserResult {
  final String deviceId;
  final int sensorNumber;

  TopicParserResult({
    required this.deviceId,
    required this.sensorNumber,
  });
}

class TopicParser {
  /// Expected format:
  /// device/{deviceId}/sensor/{sensorNumber}/data
  static TopicParserResult? parse(String topic) {
    final parts = topic.split('/');

    if (parts.length != 5) return null;
    if (parts[0] != 'device') return null;
    if (parts[2] != 'sensor') return null;
    if (parts[4] != 'data') return null;

    final deviceId = parts[1];
    final sensorNumber = int.tryParse(parts[3]);

    if (sensorNumber == null) return null;

    return TopicParserResult(
      deviceId: deviceId,
      sensorNumber: sensorNumber,
    );
  }
}
