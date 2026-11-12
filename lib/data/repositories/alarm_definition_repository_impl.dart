import '/models/alarm_definition.dart';
import '../services/firestore_service.dart';
import 'alarm_definition_repository.dart';

class AlarmDefinitionRepositoryImpl implements AlarmDefinitionRepository {
  final FirestoreService firestore;

  AlarmDefinitionRepositoryImpl(this.firestore);

  @override
  Future<List<AlarmDefinition>> getAllDefinitions() async {
    final snapshot = await firestore.globalAlarmsRef().get();
    return snapshot.docs
        .map((doc) => AlarmDefinition.fromMap(doc.id, doc.data()))
        .toList();
  }

  @override
  Future<AlarmDefinition?> getDefinition(String alarmType) async {
    final doc = await firestore.globalAlarmDoc(alarmType).get();
    if (!doc.exists) return null;
    return AlarmDefinition.fromMap(doc.id, doc.data()!);
  }

  @override
  Future<void> updateDefinition(AlarmDefinition definition) async {
    await firestore.globalAlarmDoc(definition.type).set(definition.toMap());
  }
}
