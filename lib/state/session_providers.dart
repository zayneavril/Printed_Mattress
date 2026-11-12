import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/session.dart';
part 'session_providers.g.dart';


@riverpod
class ActiveSession extends _$ActiveSession {
  @override
  Session? build() {
    return null; // no session until user starts one
  }

  void start(Session session) {
    state = session;
  }

  void end() {
    state = null;
  }
}

@riverpod
class SessionStatus extends _$SessionStatus {
  @override
  String build() {
    return 'idle'; // idle | running | ended
  }

  void setRunning() => state = 'running';
  void setEnded() => state = 'ended';
  void reset() => state = 'idle';
}

@riverpod
class SessionHistory extends _$SessionHistory {
  @override
  Future<List<Session>> build(String patientId) async {
    final snap = await FirebaseFirestore.instance
        .collection('patients')
        .doc(patientId)
        .collection('Printed_sessions')
        .orderBy('startTime', descending: true)
        .get();

    return snap.docs
        .map((d) => Session.fromMap(d.id, d.data()))
        .where((s) => s.endTime != null) // completed sessions only
        .toList();
  }
}

