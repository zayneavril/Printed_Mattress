// import 'package:cloud_firestore/cloud_firestore.dart';
// import '/models/patient.dart';
// import '/models/monitoring_session.dart';
// import '/models/sensor_readings.dart';
//
// class FirestoreRepository {
//   final _db = FirebaseFirestore.instance;
//
//   Future<void> createPatient(Patient p) async {
//     await _db.collection('patients').doc(p.id).set(p.toMap());
//   }
//
//   Future<void> startSession(MonitoringSession s) async {
//     await _db
//         .collection('patients')
//         .doc(s.patientId)
//         .collection('sessions')
//         .doc(s.sessionId)
//         .set(s.toMap());
//   }
//
//   Future<void> stopSession(MonitoringSession s) async {
//     await _db
//         .collection('patients')
//         .doc(s.patientId)
//         .collection('sessions')
//         .doc(s.sessionId)
//         .update({'endTime': s.endTime!.toIso8601String()});
//   }
//
//   Future<void> saveReading(
//       String patientId,
//       String sessionId,
//       SensorReading r,
//       ) async {
//     await _db
//         .collection('patients')
//         .doc(patientId)
//         .collection('sessions')
//         .doc(sessionId)
//         .collection('readings')
//         .doc(r.timestamp.millisecondsSinceEpoch.toString())
//         .set({
//       'timestamp': r.timestamp.toIso8601String(),
//       'sensorNumber': r.sensorNumber,
//       'values': r.values,
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/patient.dart';
import '/models/monitoring_session.dart';
import '/models/sensor_readings.dart';
import '/models/patient_alarm_settings.dart';

class FirestoreRepository {
  final _db = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // -----------------------------
  // PATIENTS
  // -----------------------------

  Future<void> createPatient(Patient p) async {
    await _db.collection('patients').doc(p.id).set(p.toJson());
  }

  Future<void> updatePatient(Patient p) async {
    await _db.collection('patients').doc(p.id).update(p.toJson());
  }

  Future<void> deletePatient(String patientId) async {
    await _db.collection('patients').doc(patientId).delete();
  }

  Stream<List<Patient>> streamPatients() {
    return _db.collection('patients').snapshots().map(
          (snap) =>
          snap.docs
              .map((d) => Patient.fromJson(d.data()))
              .toList(),
    );
  }

  // -----------------------------
  // SESSIONS
  // -----------------------------

  Future<void> startSession(MonitoringSession s) async {
    await _db
        .collection('patients')
        .doc(s.patientId)
        .collection('sessions')
        .doc(s.sessionId)
        .set({
      ...s.toMap(),
      'startTime': FieldValue.serverTimestamp(),
    });
  }

  Future<void> stopSession(MonitoringSession s) async {
    await _db
        .collection('patients')
        .doc(s.patientId)
        .collection('sessions')
        .doc(s.sessionId)
        .update({'endTime': Timestamp.fromDate(s.endTime!)});
  }

  Stream<List<MonitoringSession>> streamSessions(String patientId) {
    return _db
        .collection('patients')
        .doc(patientId)
        .collection('sessions')
        .orderBy('startTime')
        .snapshots()
        .map((snap) =>
        snap.docs
            .map((d) => MonitoringSession.fromMap(d.data()))
            .toList());
  }

  // -----------------------------
  // READINGS
  // -----------------------------

  // Future<void> saveReading(
  //     String patientId,
  //     String sessionId,
  //     SensorReading r,
  //     ) async {
  //   await _db
  //       .collection('patients')
  //       .doc(patientId)
  //       .collection('sessions')
  //       .doc(sessionId)
  //       .collection('readings')
  //       .doc(r.timestamp.millisecondsSinceEpoch.toString())
  //       .set(r.toMap());
  // }

  Future<void> saveSensorReading({
    required String patientId,
    required String sessionId,
    required int sensorNumber,
    required double value,
  }) async {
    final ref = _db
        .collection('patients')
        .doc(patientId)
        .collection('sessions')
        .doc(sessionId)
        .collection('sensors')
        .doc(sensorNumber.toString())
        .collection('readings');

    await ref.add({
      'value': value,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }


  //
  // Stream<List<SensorReading>> streamReadings(
  //     String patientId,
  //     String sessionId,
  //     ) {
  //   return _db
  //       .collection('patients')
  //       .doc(patientId)
  //       .collection('sessions')
  //       .doc(sessionId)
  //       .collection('readings')
  //       .orderBy('timestamp')
  //       .snapshots()
  //       .map((snap) => snap.docs
  //       .map((d) => SensorReading.fromMap(d.data()))
  //       .toList());
  // }

  Stream<List<SensorReading>> streamSensorReadings({
    required String patientId,
    required String sessionId,
    required int sensorNumber,
  }) {
    return _db
        .collection('patients')
        .doc(patientId)
        .collection('sessions')
        .doc(sessionId)
        .collection('sensors')
        .doc(sensorNumber.toString())
        .collection('readings')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snap) =>
          snap.docs.map(
                (d) =>
                SensorReading(
                  id: d.id,
                  sensorNumber: sensorNumber,
                  timestamp: (d['timestamp'] as Timestamp).toDate(),
                  values: [(d['value'] as num).toDouble()],
                ),
          ).toList(),
    );
  }


//
//   Future<List<SensorReading>> getReadingsByDateRange(
//       String patientId,
//       String sessionId,
//       DateTime start,
//       DateTime end,
//       ) async {
//     final snap = await _db
//         .collection('patients')
//         .doc(patientId)
//         .collection('sessions')
//         .doc(sessionId)
//         .collection('readings')
//         .where('timestamp', isGreaterThanOrEqualTo: start.toIso8601String())
//         .where('timestamp', isLessThanOrEqualTo: end.toIso8601String())
//         .get();
//
//     return snap.docs
//         .map((d) => SensorReading.fromMap(d.data()))
//         .toList();
//   }
// }

  Future<List<SensorReading>> getSensorReadingsByDateRange({
    required String patientId,
    required String sessionId,
    required int sensorNumber,
    required DateTime start,
    required DateTime end,
  }) async {
    final snap = await _db
        .collection('patients')
        .doc(patientId)
        .collection('sessions')
        .doc(sessionId)
        .collection('sensors')
        .doc(sensorNumber.toString())
        .collection('readings')
        .where(
      'timestamp',
      isGreaterThanOrEqualTo: Timestamp.fromDate(start),
    )
        .where(
      'timestamp',
      isLessThanOrEqualTo: Timestamp.fromDate(end),
    )
        .orderBy('timestamp')
        .get();

    return snap.docs.map(
          (d) =>
          SensorReading(
            id: d.id,
            sensorNumber: sensorNumber,
            timestamp: (d['timestamp'] as Timestamp).toDate(),
            values: [(d['value'] as num).toDouble()],
          ),
    ).toList();
  }

  Future<void> savePatientAlarmSettings(
      String patientId,
      PatientAlarmSettings settings,
      ) async {
    await _db
        .collection('patients')
        .doc(patientId)
        .collection('settings')
        .doc('alarms')
        .set(settings.toMap());
  }

  Future<PatientAlarmSettings>
  loadPatientAlarmSettings(
      String patientId,
      ) async {
    final doc = await _db
        .collection('patients')
        .doc(patientId)
        .collection('settings')
        .doc('alarms')
        .get();

    if (!doc.exists) {
      return PatientAlarmSettings.defaults();
    }

    return PatientAlarmSettings.fromMap(
      doc.data()!,
    );
  }



}
