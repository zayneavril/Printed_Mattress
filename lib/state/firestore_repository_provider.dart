import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart' show Ref;
import '../data/repositories/firestore_repository.dart';

part 'firestore_repository_provider.g.dart';

@riverpod
FirestoreRepository firestoreRepository(Ref ref) {
  return FirestoreRepository();
}
