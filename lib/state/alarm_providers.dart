import 'package:riverpod/riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/alarms.dart';
import '../models/alarm_definition.dart';
import '../models/alarm_override.dart';

part 'alarm_providers.g.dart';

@riverpod
class AlarmsEnabled extends _$AlarmsEnabled {
  @override
  bool build() => false; // alarms off for now

  void enable() => state = true;
  void disable() => state = false;
}

@riverpod
class GlobalAlarmDefinitions extends _$GlobalAlarmDefinitions {
  @override
  Future<List<AlarmDefinition>> build() async {
    return const []; // future Firestore load
  }
}

@riverpod
class PatientAlarmOverrides extends _$PatientAlarmOverrides {
  @override
  Future<List<AlarmOverride>> build(String patientId) async {
    return const []; // future Firestore load
  }
}

@riverpod
class ActiveAlarms extends _$ActiveAlarms {
  @override
  List<Alarm> build() => [];

  void add(Alarm alarm) => state = [...state, alarm];
  void clear() => state = [];
}

@riverpod
class AlarmHistory extends _$AlarmHistory {
  @override
  Future<List<Alarm>> build(String patientId, String sessionId) async {
    return const []; // future Firestore load
  }
}
