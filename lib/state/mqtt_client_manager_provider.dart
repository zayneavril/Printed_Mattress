import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/services/mqtt_client_manager.dart';
import 'mqtt_providers.dart';

part 'mqtt_client_manager_provider.g.dart';

@riverpod
MqttClientManager mqttClientManager(MqttClientManagerRef ref) {
  final bridge = ref.watch(mqttBridgeProvider);
  return MqttClientManager(
    mqttService: bridge,
    ref: ref,
  );
}

