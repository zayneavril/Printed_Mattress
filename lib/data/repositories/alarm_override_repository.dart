import '../../models/alarm_override.dart';

abstract class AlarmOverrideRepository {
  Future<AlarmOverride?> getOverride(String patientId, String alarmType);
  Future<void> setOverride(String patientId, AlarmOverride override);
}
