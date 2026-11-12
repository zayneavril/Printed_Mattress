import '../../models/alarms.dart';
import '../services/firestore_service.dart';
import 'alarm_repository.dart';

class AlarmRepositoryImpl implements AlarmRepository {
  final FirestoreService firestore;

  AlarmRepositoryImpl(this.firestore);

  @override
  Stream<List<Alarm>> streamAlarms(String patientId, String sessionId) {
    return firestore
        .alarmsRef(patientId, sessionId)
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Alarm.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  @override
  Future<void> saveAlarm(
      String patientId,
      String sessionId,
      Alarm alarm,
      ) async {
    await firestore
        .alarmDoc(patientId, sessionId, alarm.id)
        .set(alarm.toMap());
  }

  @override
  Future<void> acknowledgeAlarm(
      String patientId,
      String sessionId,
      String alarmId,
      ) async {
    await firestore
        .alarmDoc(patientId, sessionId, alarmId)
        .update({'acknowledged': true});
  }
}
