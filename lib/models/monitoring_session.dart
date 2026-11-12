// class MonitoringSession {
//   final String sessionId;
//   final String sessionName;
//   final String patientId;
//   final DateTime startTime;
//   final DateTime? endTime;
//
//   MonitoringSession({
//     required this.sessionId,
//     required this.sessionName,
//     required this.patientId,
//     required this.startTime,
//     this.endTime,
//   });
//
//   Map<String, dynamic> toMap() => {
//     'sessionId': sessionId,
//     'sessionName': sessionName,
//     'patientId': patientId,
//     'startTime': startTime.toIso8601String(),
//     'endTime': endTime?.toIso8601String(),
//   };
// }

class MonitoringSession {
  final String sessionId;
  final String patientId;
  final String sessionName;
  final DateTime startTime;
  final DateTime? endTime;

  MonitoringSession({
    required this.sessionId,
    required this.patientId,
    required this.sessionName,
    required this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'patientId': patientId,
      'sessionName': sessionName,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
    };
  }

  factory MonitoringSession.fromMap(Map<String, dynamic> map) {
    return MonitoringSession(
      sessionId: map['sessionId'],
      patientId: map['patientId'],
      sessionName: map['sessionName'],
      startTime: DateTime.parse(map['startTime']),
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
    );
  }
}
