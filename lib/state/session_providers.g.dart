// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeSessionHash() => r'3ccf39168cefaff070501b84de3fc30ab4236334';

/// See also [ActiveSession].
@ProviderFor(ActiveSession)
final activeSessionProvider =
    AutoDisposeNotifierProvider<ActiveSession, Session?>.internal(
      ActiveSession.new,
      name: r'activeSessionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeSessionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActiveSession = AutoDisposeNotifier<Session?>;
String _$sessionStatusHash() => r'ba00bda4b1940f6214f964a13dfdfd2a178fb3f3';

/// See also [SessionStatus].
@ProviderFor(SessionStatus)
final sessionStatusProvider =
    AutoDisposeNotifierProvider<SessionStatus, String>.internal(
      SessionStatus.new,
      name: r'sessionStatusProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SessionStatus = AutoDisposeNotifier<String>;
String _$sessionHistoryHash() => r'4737adce70e367fd55fdcdf27b97c8e8619cb621';

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

abstract class _$SessionHistory
    extends BuildlessAutoDisposeAsyncNotifier<List<Session>> {
  late final String patientId;

  FutureOr<List<Session>> build(String patientId);
}

/// See also [SessionHistory].
@ProviderFor(SessionHistory)
const sessionHistoryProvider = SessionHistoryFamily();

/// See also [SessionHistory].
class SessionHistoryFamily extends Family<AsyncValue<List<Session>>> {
  /// See also [SessionHistory].
  const SessionHistoryFamily();

  /// See also [SessionHistory].
  SessionHistoryProvider call(String patientId) {
    return SessionHistoryProvider(patientId);
  }

  @override
  SessionHistoryProvider getProviderOverride(
    covariant SessionHistoryProvider provider,
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
  String? get name => r'sessionHistoryProvider';
}

/// See also [SessionHistory].
class SessionHistoryProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<SessionHistory, List<Session>> {
  /// See also [SessionHistory].
  SessionHistoryProvider(String patientId)
    : this._internal(
        () => SessionHistory()..patientId = patientId,
        from: sessionHistoryProvider,
        name: r'sessionHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sessionHistoryHash,
        dependencies: SessionHistoryFamily._dependencies,
        allTransitiveDependencies:
            SessionHistoryFamily._allTransitiveDependencies,
        patientId: patientId,
      );

  SessionHistoryProvider._internal(
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
  FutureOr<List<Session>> runNotifierBuild(covariant SessionHistory notifier) {
    return notifier.build(patientId);
  }

  @override
  Override overrideWith(SessionHistory Function() create) {
    return ProviderOverride(
      origin: this,
      override: SessionHistoryProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SessionHistory, List<Session>>
  createElement() {
    return _SessionHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionHistoryProvider && other.patientId == patientId;
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
mixin SessionHistoryRef on AutoDisposeAsyncNotifierProviderRef<List<Session>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _SessionHistoryProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<SessionHistory, List<Session>>
    with SessionHistoryRef {
  _SessionHistoryProviderElement(super.provider);

  @override
  String get patientId => (origin as SessionHistoryProvider).patientId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
