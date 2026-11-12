// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$alarmsEnabledHash() => r'1cf7484003d14a9f0fde6c0e607b9686c1b3bcc6';

/// See also [AlarmsEnabled].
@ProviderFor(AlarmsEnabled)
final alarmsEnabledProvider =
    AutoDisposeNotifierProvider<AlarmsEnabled, bool>.internal(
      AlarmsEnabled.new,
      name: r'alarmsEnabledProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$alarmsEnabledHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AlarmsEnabled = AutoDisposeNotifier<bool>;
String _$globalAlarmDefinitionsHash() =>
    r'd6d63c045e095a4eccb2d82e5ef35b17de9599d2';

/// See also [GlobalAlarmDefinitions].
@ProviderFor(GlobalAlarmDefinitions)
final globalAlarmDefinitionsProvider =
    AutoDisposeAsyncNotifierProvider<
      GlobalAlarmDefinitions,
      List<AlarmDefinition>
    >.internal(
      GlobalAlarmDefinitions.new,
      name: r'globalAlarmDefinitionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$globalAlarmDefinitionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GlobalAlarmDefinitions =
    AutoDisposeAsyncNotifier<List<AlarmDefinition>>;
String _$patientAlarmOverridesHash() =>
    r'f0af78a2405a94097073c74c7b1c5a6f2b549ebb';

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

abstract class _$PatientAlarmOverrides
    extends BuildlessAutoDisposeAsyncNotifier<List<AlarmOverride>> {
  late final String patientId;

  FutureOr<List<AlarmOverride>> build(String patientId);
}

/// See also [PatientAlarmOverrides].
@ProviderFor(PatientAlarmOverrides)
const patientAlarmOverridesProvider = PatientAlarmOverridesFamily();

/// See also [PatientAlarmOverrides].
class PatientAlarmOverridesFamily
    extends Family<AsyncValue<List<AlarmOverride>>> {
  /// See also [PatientAlarmOverrides].
  const PatientAlarmOverridesFamily();

  /// See also [PatientAlarmOverrides].
  PatientAlarmOverridesProvider call(String patientId) {
    return PatientAlarmOverridesProvider(patientId);
  }

  @override
  PatientAlarmOverridesProvider getProviderOverride(
    covariant PatientAlarmOverridesProvider provider,
  ) {
    return call(provider.patientId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'patientAlarmOverridesProvider';
}

/// See also [PatientAlarmOverrides].
class PatientAlarmOverridesProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          PatientAlarmOverrides,
          List<AlarmOverride>
        > {
  /// See also [PatientAlarmOverrides].
  PatientAlarmOverridesProvider(String patientId)
    : this._internal(
        () => PatientAlarmOverrides()..patientId = patientId,
        from: patientAlarmOverridesProvider,
        name: r'patientAlarmOverridesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$patientAlarmOverridesHash,
        dependencies: PatientAlarmOverridesFamily._dependencies,
        allTransitiveDependencies:
            PatientAlarmOverridesFamily._allTransitiveDependencies,
        patientId: patientId,
      );

  PatientAlarmOverridesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
  }) : super.internal();

  final String patientId;

  @override
  FutureOr<List<AlarmOverride>> runNotifierBuild(
    covariant PatientAlarmOverrides notifier,
  ) {
    return notifier.build(patientId);
  }

  @override
  Override overrideWith(PatientAlarmOverrides Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientAlarmOverridesProvider._internal(
        () => create()..patientId = patientId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    PatientAlarmOverrides,
    List<AlarmOverride>
  >
  createElement() {
    return _PatientAlarmOverridesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientAlarmOverridesProvider &&
        other.patientId == patientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientAlarmOverridesRef
    on AutoDisposeAsyncNotifierProviderRef<List<AlarmOverride>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _PatientAlarmOverridesProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          PatientAlarmOverrides,
          List<AlarmOverride>
        >
    with PatientAlarmOverridesRef {
  _PatientAlarmOverridesProviderElement(super.provider);

  @override
  String get patientId => (origin as PatientAlarmOverridesProvider).patientId;
}

String _$activeAlarmsHash() => r'8558a33255c43f8eb1e2eac721060fe201db16d1';

/// See also [ActiveAlarms].
@ProviderFor(ActiveAlarms)
final activeAlarmsProvider =
    AutoDisposeNotifierProvider<ActiveAlarms, List<Alarm>>.internal(
      ActiveAlarms.new,
      name: r'activeAlarmsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeAlarmsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActiveAlarms = AutoDisposeNotifier<List<Alarm>>;
String _$alarmHistoryHash() => r'c41cc2ec4b6fa0316acfa0295ec4c7b4e59a884f';

abstract class _$AlarmHistory
    extends BuildlessAutoDisposeAsyncNotifier<List<Alarm>> {
  late final String patientId;
  late final String sessionId;

  FutureOr<List<Alarm>> build(String patientId, String sessionId);
}

/// See also [AlarmHistory].
@ProviderFor(AlarmHistory)
const alarmHistoryProvider = AlarmHistoryFamily();

/// See also [AlarmHistory].
class AlarmHistoryFamily extends Family<AsyncValue<List<Alarm>>> {
  /// See also [AlarmHistory].
  const AlarmHistoryFamily();

  /// See also [AlarmHistory].
  AlarmHistoryProvider call(String patientId, String sessionId) {
    return AlarmHistoryProvider(patientId, sessionId);
  }

  @override
  AlarmHistoryProvider getProviderOverride(
    covariant AlarmHistoryProvider provider,
  ) {
    return call(provider.patientId, provider.sessionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'alarmHistoryProvider';
}

/// See also [AlarmHistory].
class AlarmHistoryProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AlarmHistory, List<Alarm>> {
  /// See also [AlarmHistory].
  AlarmHistoryProvider(String patientId, String sessionId)
    : this._internal(
        () => AlarmHistory()
          ..patientId = patientId
          ..sessionId = sessionId,
        from: alarmHistoryProvider,
        name: r'alarmHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$alarmHistoryHash,
        dependencies: AlarmHistoryFamily._dependencies,
        allTransitiveDependencies:
            AlarmHistoryFamily._allTransitiveDependencies,
        patientId: patientId,
        sessionId: sessionId,
      );

  AlarmHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
    required this.sessionId,
  }) : super.internal();

  final String patientId;
  final String sessionId;

  @override
  FutureOr<List<Alarm>> runNotifierBuild(covariant AlarmHistory notifier) {
    return notifier.build(patientId, sessionId);
  }

  @override
  Override overrideWith(AlarmHistory Function() create) {
    return ProviderOverride(
      origin: this,
      override: AlarmHistoryProvider._internal(
        () => create()
          ..patientId = patientId
          ..sessionId = sessionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AlarmHistory, List<Alarm>>
  createElement() {
    return _AlarmHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlarmHistoryProvider &&
        other.patientId == patientId &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AlarmHistoryRef on AutoDisposeAsyncNotifierProviderRef<List<Alarm>> {
  /// The parameter `patientId` of this provider.
  String get patientId;

  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _AlarmHistoryProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AlarmHistory, List<Alarm>>
    with AlarmHistoryRef {
  _AlarmHistoryProviderElement(super.provider);

  @override
  String get patientId => (origin as AlarmHistoryProvider).patientId;
  @override
  String get sessionId => (origin as AlarmHistoryProvider).sessionId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
