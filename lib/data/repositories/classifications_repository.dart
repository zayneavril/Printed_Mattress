import 'package:first_app/models/ML_classifications.dart';

abstract class ClassificationsRepositoryRepository {
  Stream<List<PositionClassification>> watchClassificationsForPatient(String patientId);
  Future<void> savePrediction(PositionClassification classification);
}
