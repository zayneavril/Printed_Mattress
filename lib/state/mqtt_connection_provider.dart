import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mqtt_connection_provider.g.dart';

@riverpod
class MqttConnection extends _$MqttConnection {
  @override
  bool build() => false;

  void setConnected(bool value) => state = value;
}
