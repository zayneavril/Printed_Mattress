import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> patientsRef() {
    return _db.collection('patients');
  }

  DocumentReference<Map<String, dynamic>> patientDoc(String patientId) {
    return patientsRef().doc(patientId);
  }

  CollectionReference<Map<String, dynamic>> sessionsRef(String patientId) {
    return patientDoc(patientId).collection('Printed_sessions');
  }

  DocumentReference<Map<String, dynamic>> sessionDoc(String patientId, String sessionId) {
    return sessionsRef(patientId).doc(sessionId);
  }


  CollectionReference<Map<String, dynamic>> readingsRef(
      String patientId,
      String sessionId,
      ) {
    return sessionDoc(patientId, sessionId).collection('readings');
  }

  DocumentReference<Map<String, dynamic>> readingDoc(
      String patientId,
      String sessionId,
      String readingId,
      ) {
    return readingsRef(patientId, sessionId).doc(readingId);
  }

// GLOBAL ALARM DEFINITIONS
  CollectionReference<Map<String, dynamic>> globalAlarmsRef() {
    return _db.collection('global_alarms');
  }

  DocumentReference<Map<String, dynamic>> globalAlarmDoc(String alarmType) {
    return globalAlarmsRef().doc(alarmType);
  }

// PER-PATIENT OVERRIDES
  CollectionReference<Map<String, dynamic>> alarmOverridesRef(String patientId) {
    return patientDoc(patientId).collection('alarm_overrides');
  }

  DocumentReference<Map<String, dynamic>> alarmOverrideDoc(
      String patientId,
      String alarmType,
      ) {
    return alarmOverridesRef(patientId).doc(alarmType);
  }

// ALARM INSTANCES (already partly implemented)
  CollectionReference<Map<String, dynamic>> alarmsRef(
      String patientId,
      String sessionId,
      ) {
    return sessionDoc(patientId, sessionId).collection('alarms');
  }

  DocumentReference<Map<String, dynamic>> alarmDoc(
      String patientId,
      String sessionId,
      String alarmId,
      ) {
    return alarmsRef(patientId, sessionId).doc(alarmId);

  }

}


