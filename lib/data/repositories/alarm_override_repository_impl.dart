import '/models/alarm_override.dart';
import '../services/firestore_service.dart';
import 'alarm_override_repository.dart';

class AlarmOverrideRepositoryImpl implements AlarmOverrideRepository {
  final FirestoreService firestore;

  AlarmOverrideRepositoryImpl(this.firestore);

  @override
  Future<AlarmOverride?> getOverride(String patientId, String alarmType) async {
    final doc = await firestore.alarmOverrideDoc(patientId, alarmType).get();
    if (!doc.exists) return null;
    return AlarmOverride.fromMap(doc.id, doc.data()!);
  }

  @override
  Future<void> setOverride(String patientId, AlarmOverride override) async {
    await firestore
        .alarmOverrideDoc(patientId, override.alarmType)
        .set(override.toMap());
  }
}
