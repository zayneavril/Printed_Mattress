// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playbackModeHash() => r'ea58893b59f66e6afc53ddcfd0aa30d18922768e';

/// See also [PlaybackMode].
@ProviderFor(PlaybackMode)
final playbackModeProvider =
    AutoDisposeNotifierProvider<PlaybackMode, String>.internal(
      PlaybackMode.new,
      name: r'playbackModeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$playbackModeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PlaybackMode = AutoDisposeNotifier<String>;
String _$playbackFiltersControllerHash() =>
    r'3a948e034c7d78b62a3e4c7b4473097cf5037f31';

/// See also [PlaybackFiltersController].
@ProviderFor(PlaybackFiltersController)
final playbackFiltersControllerProvider =
    AutoDisposeNotifierProvider<
      PlaybackFiltersController,
      PlaybackFilters
    >.internal(
      PlaybackFiltersController.new,
      name: r'playbackFiltersControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$playbackFiltersControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PlaybackFiltersController = AutoDisposeNotifier<PlaybackFilters>;
String _$playbackDataHash() => r'045d6cccf234938dc4186917ead0fa25c63716fe';

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

abstract class _$PlaybackData
    extends BuildlessAutoDisposeAsyncNotifier<List<SensorReading>> {
  late final PlaybackFilters filters;

  FutureOr<List<SensorReading>> build(PlaybackFilters filters);
}

/// See also [PlaybackData].
@ProviderFor(PlaybackData)
const playbackDataProvider = PlaybackDataFamily();

/// See also [PlaybackData].
class PlaybackDataFamily extends Family<AsyncValue<List<SensorReading>>> {
  /// See also [PlaybackData].
  const PlaybackDataFamily();

  /// See also [PlaybackData].
  PlaybackDataProvider call(PlaybackFilters filters) {
    return PlaybackDataProvider(filters);
  }

  @override
  PlaybackDataProvider getProviderOverride(
    covariant PlaybackDataProvider provider,
  ) {
    return call(provider.filters);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'playbackDataProvider';
}

/// See also [PlaybackData].
class PlaybackDataProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          PlaybackData,
          List<SensorReading>
        > {
  /// See also [PlaybackData].
  PlaybackDataProvider(PlaybackFilters filters)
    : this._internal(
        () => PlaybackData()..filters = filters,
        from: playbackDataProvider,
        name: r'playbackDataProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$playbackDataHash,
        dependencies: PlaybackDataFamily._dependencies,
        allTransitiveDependencies:
            PlaybackDataFamily._allTransitiveDependencies,
        filters: filters,
      );

  PlaybackDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filters,
  }) : super.internal();

  final PlaybackFilters filters;

  @override
  FutureOr<List<SensorReading>> runNotifierBuild(
    covariant PlaybackData notifier,
  ) {
    return notifier.build(filters);
  }

  @override
  Override overrideWith(PlaybackData Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlaybackDataProvider._internal(
        () => create()..filters = filters,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filters: filters,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PlaybackData, List<SensorReading>>
  createElement() {
    return _PlaybackDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaybackDataProvider && other.filters == filters;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filters.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PlaybackDataRef
    on AutoDisposeAsyncNotifierProviderRef<List<SensorReading>> {
  /// The parameter `filters` of this provider.
  PlaybackFilters get filters;
}

class _PlaybackDataProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          PlaybackData,
          List<SensorReading>
        >
    with PlaybackDataRef {
  _PlaybackDataProviderElement(super.provider);

  @override
  PlaybackFilters get filters => (origin as PlaybackDataProvider).filters;
}

String _$playbackControllerHash() =>
    r'f1de0a1bb5a677d2d47fe0e1f8bc6087aab4c2dd';

/// See also [PlaybackController].
@ProviderFor(PlaybackController)
final playbackControllerProvider =
    AutoDisposeNotifierProvider<PlaybackController, Duration>.internal(
      PlaybackController.new,
      name: r'playbackControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$playbackControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PlaybackController = AutoDisposeNotifier<Duration>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
