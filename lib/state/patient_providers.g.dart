// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientListHash() => r'8961b969ca45338fdf58f20d8b51c9da4e4c5c87';

/// See also [PatientList].
@ProviderFor(PatientList)
final patientListProvider =
    AutoDisposeAsyncNotifierProvider<PatientList, List<Patient>>.internal(
      PatientList.new,
      name: r'patientListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$patientListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PatientList = AutoDisposeAsyncNotifier<List<Patient>>;
String _$activePatientHash() => r'c9a29719f349e48d1dcc44d8272e7963c107d4e0';

/// See also [ActivePatient].
@ProviderFor(ActivePatient)
final activePatientProvider =
    AutoDisposeNotifierProvider<ActivePatient, Patient?>.internal(
      ActivePatient.new,
      name: r'activePatientProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activePatientHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActivePatient = AutoDisposeNotifier<Patient?>;
String _$patientOverridesControllerHash() =>
    r'682b477d58a66f4c3a0470ae00e5f4cebe12e17f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PatientOverridesController
    extends BuildlessAutoDisposeAsyncNotifier<PatientOverrides?> {
  late final Patient? patient;

  FutureOr<PatientOverrides?> build(Patient? patient);
}

/// See also [PatientOverridesController].
@ProviderFor(PatientOverridesController)
const patientOverridesControllerProvider = PatientOverridesControllerFamily();

/// See also [PatientOverridesController].
class PatientOverridesControllerFamily
    extends Family<AsyncValue<PatientOverrides?>> {
  /// See also [PatientOverridesController].
  const PatientOverridesControllerFamily();

  /// See also [PatientOverridesController].
  PatientOverridesControllerProvider call(Patient? patient) {
    return PatientOverridesControllerProvider(patient);
  }

  @override
  PatientOverridesControllerProvider getProviderOverride(
    covariant PatientOverridesControllerProvider provider,
  ) {
    return call(provider.patient);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'patientOverridesControllerProvider';
}

/// See also [PatientOverridesController].
class PatientOverridesControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          PatientOverridesController,
          PatientOverrides?
        > {
  /// See also [PatientOverridesController].
  PatientOverridesControllerProvider(Patient? patient)
    : this._internal(
        () => PatientOverridesController()..patient = patient,
        from: patientOverridesControllerProvider,
        name: r'patientOverridesControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$patientOverridesControllerHash,
        dependencies: PatientOverridesControllerFamily._dependencies,
        allTransitiveDependencies:
            PatientOverridesControllerFamily._allTransitiveDependencies,
        patient: patient,
      );

  PatientOverridesControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patient,
  }) : super.internal();

  final Patient? patient;

  @override
  FutureOr<PatientOverrides?> runNotifierBuild(
    covariant PatientOverridesController notifier,
  ) {
    return notifier.build(patient);
  }

  @override
  Override overrideWith(PatientOverridesController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientOverridesControllerProvider._internal(
        () => create()..patient = patient,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patient: patient,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    PatientOverridesController,
    PatientOverrides?
  >
  createElement() {
    return _PatientOverridesControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientOverridesControllerProvider &&
        other.patient == patient;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patient.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientOverridesControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientOverrides?> {
  /// The parameter `patient` of this provider.
  Patient? get patient;
}

class _PatientOverridesControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          PatientOverridesController,
          PatientOverrides?
        >
    with PatientOverridesControllerRef {
  _PatientOverridesControllerProviderElement(super.provider);

  @override
  Patient? get patient =>
      (origin as PatientOverridesControllerProvider).patient;
}

String _$activePatientAlarmSettingsHash() =>
    r'f86d9891a532f08fb6a989d081e1dcf45cba1f30';

/// See also [ActivePatientAlarmSettings].
@ProviderFor(ActivePatientAlarmSettings)
final activePatientAlarmSettingsProvider =
    AutoDisposeAsyncNotifierProvider<
      ActivePatientAlarmSettings,
      PatientAlarmSettings?
    >.internal(
      ActivePatientAlarmSettings.new,
      name: r'activePatientAlarmSettingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activePatientAlarmSettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActivePatientAlarmSettings =
    AutoDisposeAsyncNotifier<PatientAlarmSettings?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
