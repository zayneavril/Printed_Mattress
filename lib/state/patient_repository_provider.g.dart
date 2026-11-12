// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientRepositoryHash() => r'f8774e81dbb142af36598633b2b7e279da528da8';

/// See also [PatientRepository].
@ProviderFor(PatientRepository)
final patientRepositoryProvider =
    AutoDisposeNotifierProvider<
      PatientRepository,
      FirestoreRepository
    >.internal(
      PatientRepository.new,
      name: r'patientRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$patientRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PatientRepository = AutoDisposeNotifier<FirestoreRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
