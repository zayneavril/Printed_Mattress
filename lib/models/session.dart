// class Session {
//   final String id;
//   final String? sessionName;
//   final DateTime startedAt;
//   final DateTime? endedAt;
//
//   bool get isActive => endedAt == null;
//
//   Session({
//     required this.id,
//     this.sessionName,
//     required this.startedAt,
//     this.endedAt,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'sessionName': sessionName,
//       'startedAt': startedAt.toIso8601String(),
//       'endedAt': endedAt?.toIso8601String(),
//     };
//   }
//
//   factory Session.fromMap(String id, Map<String, dynamic> map) {
//     return Session(
//       id: id,
//       sessionName: map['sessionName'],
//       startedAt: DateTime.parse(map['startedAt']),
//       endedAt: map['endedAt'] != null ? DateTime.parse(map['endedAt']) : null,
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Session {
final String id;
final String? sessionName;
final DateTime startTime;
final DateTime? endTime;

bool get isActive => endTime == null;

Session({
  required this.id,
  this.sessionName,
  required this.startTime,
  this.endTime,
});

/// Convert to Firestore map (used when saving)
Map<String, dynamic> toMap() {
  return {
    'sessionName': sessionName,
    'startTime': Timestamp.fromDate(startTime),
    'endTime': endTime != null ? Timestamp.fromDate(endTime!) : null,
  };
}

/// Create from Firestore document
factory Session.fromMap(String id, Map<String, dynamic> map) {
return Session(
id: id,
sessionName: map['sessionName'] as String?,
startTime: (map['startTime'] as Timestamp).toDate(),
endTime: map['endTime'] != null
? (map['endTime'] as Timestamp).toDate()
    : null,
);
}
}

