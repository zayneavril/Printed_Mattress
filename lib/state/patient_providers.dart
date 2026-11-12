import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/patient.dart';
import 'patient_repository_provider.dart';
import '../models/patient_alarm_settings.dart';
import '/data/repositories/firestore_repository.dart';
part 'patient_providers.g.dart';

class PatientOverrides {
  const PatientOverrides();
}

@riverpod
class PatientList extends _$PatientList {
  @override
  Future<List<Patient>> build() async {
    final repo = ref.read(patientRepositoryProvider.notifier);
    return repo.loadPatients();
  }
}

@riverpod
class ActivePatient extends _$ActivePatient {
  @override
  Patient? build() => null;

  void select(Patient patient) => state = patient;

  void clear() => state = null;
}

@riverpod
class PatientOverridesController extends _$PatientOverridesController {
  @override
  Future<PatientOverrides?> build(Patient? patient) async {
    if (patient == null) return null;
    return const PatientOverrides();
  }
}

@riverpod
class ActivePatientAlarmSettings
    extends _$ActivePatientAlarmSettings {

  @override
  Future<PatientAlarmSettings?> build() async {
    return null;
  }

  Future<void> load(String patientId) async {
    final repo = FirestoreRepository();

    final settings =
    await repo.loadPatientAlarmSettings(
      patientId,
    );

    state = AsyncData(settings);
  }

  void setSettings(
      PatientAlarmSettings settings,
      ) {
    state = AsyncData(settings);
  }

  void clear() {
    state = const AsyncData(null);
  }
}


