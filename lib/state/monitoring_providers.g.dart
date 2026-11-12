// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitoring_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$latestSensorValuesHash() =>
    r'41d0b8a1d3d6b3bbb264667794a738d93d7ead91';

/// See also [LatestSensorValues].
@ProviderFor(LatestSensorValues)
final latestSensorValuesProvider =
    AutoDisposeNotifierProvider<LatestSensorValues, Map<int, double>>.internal(
      LatestSensorValues.new,
      name: r'latestSensorValuesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$latestSensorValuesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LatestSensorValues = AutoDisposeNotifier<Map<int, double>>;
String _$slidingWindowHash() => r'5fe1363b847d027f54184ee8398dce341e378d6b';

/// See also [SlidingWindow].
@ProviderFor(SlidingWindow)
final slidingWindowProvider =
    AutoDisposeNotifierProvider<SlidingWindow, List<SensorReading>>.internal(
      SlidingWindow.new,
      name: r'slidingWindowProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$slidingWindowHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SlidingWindow = AutoDisposeNotifier<List<SensorReading>>;
String _$monitoringModeHash() => r'c25a3cfc3ea4333444566699a24f6f7318b4f108';

/// See also [MonitoringMode].
@ProviderFor(MonitoringMode)
final monitoringModeProvider =
    AutoDisposeNotifierProvider<MonitoringMode, String>.internal(
      MonitoringMode.new,
      name: r'monitoringModeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$monitoringModeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MonitoringMode = AutoDisposeNotifier<String>;
String _$visibleSensorsHash() => r'f69f569a223679c8edab20d74d36c23e692677a4';

/// See also [VisibleSensors].
@ProviderFor(VisibleSensors)
final visibleSensorsProvider =
    AutoDisposeNotifierProvider<VisibleSensors, Set<int>>.internal(
      VisibleSensors.new,
      name: r'visibleSensorsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$visibleSensorsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VisibleSensors = AutoDisposeNotifier<Set<int>>;
String _$legendExpandedHash() => r'e7b88ac1b2b61ec24f6c03cf20293e0228dbe2d1';

/// See also [LegendExpanded].
@ProviderFor(LegendExpanded)
final legendExpandedProvider =
    AutoDisposeNotifierProvider<LegendExpanded, bool>.internal(
      LegendExpanded.new,
      name: r'legendExpandedProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$legendExpandedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LegendExpanded = AutoDisposeNotifier<bool>;
String _$showPressureValuesHash() =>
    r'92f97698874e9bb752069d65a36077cd50afc374';

/// See also [ShowPressureValues].
@ProviderFor(ShowPressureValues)
final showPressureValuesProvider =
    AutoDisposeNotifierProvider<ShowPressureValues, bool>.internal(
      ShowPressureValues.new,
      name: r'showPressureValuesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$showPressureValuesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ShowPressureValues = AutoDisposeNotifier<bool>;
String _$sessionPanelExpandedHash() =>
    r'2d61892fc601b9d7ece7b9dedad54b6244d2efd7';

/// See also [SessionPanelExpanded].
@ProviderFor(SessionPanelExpanded)
final sessionPanelExpandedProvider =
    AutoDisposeNotifierProvider<SessionPanelExpanded, bool>.internal(
      SessionPanelExpanded.new,
      name: r'sessionPanelExpandedProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionPanelExpandedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SessionPanelExpanded = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
