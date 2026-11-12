
class FrameBuilder {
  static List<double> buildFrame(
      Map<int, double> sensorValues,
      ) {
    return List.generate(36, (index) {
      final sensorId = index + 1;

      final value = sensorValues[sensorId];

      if (value == null) {
        throw Exception(
          'Sensor $sensorId missing from frame.',
        );
      }

      return value;
    });
  }
}