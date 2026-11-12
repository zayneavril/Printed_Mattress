

// class Patient {
//   final String name;
//   final double? height;
//   final double? weight;
//   final String id;
//
//   Patient({required this.name, this.height, this.weight, required this.id});
//
//
//
// Map<String, dynamic> toMap() {
//   return {
//     'name': name,
//     'height': height,
//     'weight': weight,
//     'id': id
//   };
// }
//
// factory Patient.fromMap(String id, Map<String, dynamic> map) {
//   return Patient(
//   id: id,
//   name: map['name'],
//   weight: map['weight'],
//   height: map['height'],
// );
// }
// }

class Patient {
  final String id;
  final String name;
  final double? height;
  final double? weight;

  Patient({
    required this.id,
    required this.name,
    this.height,
    this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
    );
  }
}
