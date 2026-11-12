import '../../models/alarms.dart';

abstract class AlarmRepository {
  Stream<List<Alarm>> streamAlarms(String patientId, String sessionId);
  Future<void> saveAlarm(String patientId, String sessionId, Alarm alarm);
  Future<void> acknowledgeAlarm(String patientId, String sessionId, String alarmId);
}
