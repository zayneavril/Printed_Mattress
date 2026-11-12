import '../../models/alarm_definition.dart';

abstract class AlarmDefinitionRepository {
  Future<List<AlarmDefinition>> getAllDefinitions();
  Future<AlarmDefinition?> getDefinition(String alarmType);
  Future<void> updateDefinition(AlarmDefinition definition);
}
