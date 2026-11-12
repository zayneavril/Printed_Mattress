class AlarmDefinition {
  final String type;            // e.g. "high_pressure", "bed_exit"
  final bool enabled;

  final double? defaultThreshold; // optional, depends on algorithm
  final int windowSize;           // e.g. 10
  final int triggerCount;         // e.g. 4

  final String algorithm;         // "threshold", "no_pressure", "movement"
  final String description;

  AlarmDefinition({
    required this.type,
    required this.enabled,
    required this.windowSize,
    required this.triggerCount,
    required this.algorithm,
    required this.description,
    this.defaultThreshold,
  });

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'defaultThreshold': defaultThreshold,
      'windowSize': windowSize,
      'triggerCount': triggerCount,
      'algorithm': algorithm,  //name of algorithm
      'description': description,
    };
  }

  factory AlarmDefinition.fromMap(String type, Map<String, dynamic> map) {
    return AlarmDefinition(
      type: type,
      enabled: map['enabled'],
      defaultThreshold: (map['defaultThreshold'] as num?)?.toDouble(),
      windowSize: map['windowSize'],
      triggerCount: map['triggerCount'],
      algorithm: map['algorithm'],
      description: map['description'],
    );
  }
}
