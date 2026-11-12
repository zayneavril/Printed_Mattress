import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/patient.dart';
import 'firestore_repository_provider.dart';
import '../data/repositories/firestore_repository.dart';

part 'patient_repository_provider.g.dart';

@riverpod
class PatientRepository extends _$PatientRepository {
  @override
  FirestoreRepository build() {
    return ref.read(firestoreRepositoryProvider);
  }

  Future<void> savePatient(Patient p) async {
    await build()
        .firestore
        .collection('patients')
        .doc(p.id)
        .set(p.toJson());
  }

  Future<List<Patient>> loadPatients() async {
    final snap = await build()
        .firestore
        .collection('patients')
        .get();

    return snap.docs
        .map((d) => Patient.fromJson(d.data()))
        .toList();

  }

  Future<void> deletePatient(String id) async {
    await build()
        .firestore
        .collection('patients')
        .doc(id)
        .delete();
  }

}
