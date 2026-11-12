class NormalisationService {
  static List<double> normalise({
    required List<double> frame,
    required List<double> baseline,
  }) {
    if (frame.length != 210) {
      throw Exception(
        'Frame must contain 36 values.',
      );
    }

    if (baseline.length != 210) {
      throw Exception(
        'Baseline must contain 36 values.',
      );
    }

    return List.generate(210, (index) {
      final base = baseline[index];

      if (base == 0) {
        return 0;
      }

      return (frame[index] - base) / base;
    });
  }
}