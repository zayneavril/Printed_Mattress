// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calibration_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$liveReadingsHash() => r'0d7d70a4979b54124ec838728308f23306604467';

/// See also [liveReadings].
@ProviderFor(liveReadings)
final liveReadingsProvider = AutoDisposeStreamProvider<SensorReading>.internal(
  liveReadings,
  name: r'liveReadingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$liveReadingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LiveReadingsRef = AutoDisposeStreamProviderRef<SensorReading>;
String _$calibrationModeHash() => r'5c0af99b1bdbb02c3f1a78736ace25e637dc1681';

/// See also [CalibrationMode].
@ProviderFor(CalibrationMode)
final calibrationModeProvider =
    AutoDisposeNotifierProvider<CalibrationMode, bool>.internal(
      CalibrationMode.new,
      name: r'calibrationModeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$calibrationModeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CalibrationMode = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
