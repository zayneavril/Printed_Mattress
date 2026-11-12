// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mqttServiceHash() => r'b62ac9f2319ef371c01a3e3d29575fc96fad10d7';

/// See also [mqttService].
@ProviderFor(mqttService)
final mqttServiceProvider = AutoDisposeProvider<MqttService>.internal(
  mqttService,
  name: r'mqttServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mqttServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MqttServiceRef = AutoDisposeProviderRef<MqttService>;
String _$mqttBridgeHash() => r'6226c7917b57f7e937ec34c9e797c002b053cfb2';

/// See also [mqttBridge].
@ProviderFor(mqttBridge)
final mqttBridgeProvider = AutoDisposeProvider<MqttStreamBridge>.internal(
  mqttBridge,
  name: r'mqttBridgeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mqttBridgeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MqttBridgeRef = AutoDisposeProviderRef<MqttStreamBridge>;
String _$mqttReadingsHash() => r'7dae1c57c6dd36a0eefbdc9b289014cc601b0946';

/// See also [mqttReadings].
@ProviderFor(mqttReadings)
final mqttReadingsProvider = AutoDisposeStreamProvider<SensorReading>.internal(
  mqttReadings,
  name: r'mqttReadingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mqttReadingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MqttReadingsRef = AutoDisposeStreamProviderRef<SensorReading>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
