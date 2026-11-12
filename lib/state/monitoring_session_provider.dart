import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/monitoring_session.dart';

part 'monitoring_session_provider.g.dart';

@riverpod
class MonitoringSessionController extends _$MonitoringSessionController {
  @override
  MonitoringSession? build() => null;

  void start(String name, String patientId) {
    state = MonitoringSession(
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
      sessionName: name,
      patientId: patientId,
      startTime: DateTime.now(),
    );
  }

  void stop() {
    if (state == null) return;
    state = MonitoringSession(
      sessionId: state!.sessionId,
      sessionName: state!.sessionName,
      patientId: state!.patientId,
      startTime: state!.startTime,
      endTime: DateTime.now(),
    );
  }

  void clear() => state = null;
}
