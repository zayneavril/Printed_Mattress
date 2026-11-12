class MaxPressureConfig {
  final bool enabled;
  final double threshold;
  final int framesRequired;

  const MaxPressureConfig({
    required this.enabled,
    required this.threshold,
    required this.framesRequired,
  });

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'threshold': threshold,
      'framesRequired': framesRequired,
    };
  }

  factory MaxPressureConfig.fromMap(
      Map<String, dynamic> map,
      ) {
    return MaxPressureConfig(
      enabled: map['enabled'] ?? true,
      threshold:
      (map['threshold'] as num?)?.toDouble() ?? 1.0,
      framesRequired:
      map['framesRequired'] ?? 5,
    );
  }
}