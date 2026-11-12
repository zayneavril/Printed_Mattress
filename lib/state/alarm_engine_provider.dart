import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart' show Ref;
import '../data/services/alarm_engine.dart';
import '../data/services/firestore_service.dart';
import '../data/repositories/alarm_definition_repository_impl.dart';
import '../data/repositories/alarm_override_repository_impl.dart';
import '../data/repositories/alarm_repository_impl.dart';

part 'alarm_engine_provider.g.dart';

@riverpod
AlarmEngine alarmEngine(Ref ref) {
  final firestore = FirestoreService();

  return AlarmEngine(
    definitionRepo: AlarmDefinitionRepositoryImpl(firestore),
    overrideRepo: AlarmOverrideRepositoryImpl(firestore),
    alarmRepo: AlarmRepositoryImpl(firestore),
  );
}


