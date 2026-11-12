import 'package:first_app/state/mqtt_connection_provider.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:riverpod/riverpod.dart' show Ref;
import '/../state/mqtt_providers.dart'; // for MqttStreamBridge
//
//
// class MqttClientManager {
//   final MqttStreamBridge mqttService;
//   final Ref ref;
//   late MqttServerClient _client;
//
//   MqttClientManager({
//     required this.mqttService,
//     required this.ref,
//   });
//
//   Future<void> connect({
//     required String broker,
//     required String clientId,
//   }) async {
//     _client = MqttServerClient(broker, clientId);
//     _client.logging(on: false);
//     _client.keepAlivePeriod = 20;
//
//     // Correct: callbacks must be instance methods
//     _client.onDisconnected = _onDisconnected;
//     _client.onConnected = _onConnected;
//
//     final connMessage = MqttConnectMessage()
//         .withClientIdentifier(clientId)
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce);
//
//     _client.connectionMessage = connMessage;
//
//     // try {
//     //   await _client.connect();
//     // } catch (e) {
//     //   print('MQTT connect() threw: $e');
//     //   _client.disconnect();
//     //   return;
//     // }
//     try {
//       await _client.connect();
//
//       print(
//         'MQTT State: '
//             '${_client.connectionStatus?.state}',
//       );
//
//       print(
//         'MQTT Return Code: '
//             '${_client.connectionStatus?.returnCode}',
//       );
//     } catch (e, s) {
//       print('MQTT connect() threw: $e');
//       print(s);
//
//       _client.disconnect();
//       return;
//     }
//
//     print('MQTT connection status: ${_client.connectionStatus}');
//
//     if (_client.connectionStatus!.state == MqttConnectionState.connected) {
//       // Update provider immediately
//       //ref.read(mqttConnectionProvider.notifier).setConnected(true);
//
//       _client.subscribe('device/+/sensor/+/data', MqttQos.atLeastOnce);
//
//       _client.updates!.listen((events) {
//         final MqttPublishMessage recMess =
//         events[0].payload as MqttPublishMessage;
//         final payload =
//         MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//         final topic = events[0].topic;
//
//         mqttService.handleMessage(
//           topic: topic,
//           payload: payload,
//         );
//       });
//     }
//   }
//
//   void _onConnected() {
//     print('MQTT connected callback fired');
//     ref.read(mqttConnectionProvider.notifier).setConnected(true);
//   }
//
//   void _onDisconnected() {
//     print('MQTT disconnected callback fired');
//     ref.read(mqttConnectionProvider.notifier).setConnected(false);
//   }
// }
//

import 'dart:async';
import 'dart:io';


class MqttClientManager {

  //StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>?
  //_mqttSubscription;

  final MqttStreamBridge mqttService;
  final Ref ref;

  late MqttServerClient _client;

  MqttClientManager({
    required this.mqttService,
    required this.ref,
  });


  Future<void> connect({
    required String broker,
    required String clientId,
  }) async {
    // try {
    //   print('Testing raw socket...');
    //
    //   final socket = await Socket.connect(
    //     '192.168.43.184',
    //     1883,
    //     timeout: const Duration(seconds: 5),
    //   );
    //
    //   print('RAW SOCKET CONNECTED');
    //
    //   await socket.close();
    // } catch (e) {
    //   print('RAW SOCKET FAILED: $e');
    // }


    print('MQTT connecting to $broker');

    _client = MqttServerClient(broker, clientId);

    print('Broker = $broker');

    print('ClientId = $clientId');

    _client.port = 1883;
    _client.useWebSocket = false;
    _client.keepAlivePeriod = 20;
    _client.logging(on: true);

    _client.onConnected = _onConnected;
    _client.onDisconnected = _onDisconnected;

    _client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    print('About to call connect()');

    try {
      await _client.connect().timeout(const Duration(seconds: 10),

      );

      print('connect() returned');

      print(
        'MQTT State: '
            '${_client.connectionStatus?.state}',
      );

      print(
        'MQTT Return Code: '
            '${_client.connectionStatus?.returnCode}',
      );
    } catch (e, s) {
      print('MQTT connect() threw: $e');
      print(s);

      try {
        _client.disconnect();
      } catch (_) {}

      return;
    }
  }

  void _onConnected() {
    print('========================');
    print('MQTT CONNECTED');
    print('========================');

    ref
        .read(mqttConnectionProvider.notifier)
        .setConnected(true);

    _client.subscribe(
      'device/+/sensor/+/data',
      MqttQos.atLeastOnce,
    );

    print(
      'Subscribed to '
          'device/+/sensor/+/data',
    );

    print('Creating MQTT listener');

    _client.updates?.listen((events) {

      print('LISTENER EVENT');

      try {
        final recMess =
        events.first.payload as MqttPublishMessage;

        final payload =
        MqttPublishPayload.bytesToStringAsString(
          recMess.payload.message,
        );

        final topic = events.first.topic;

        print('HANDLE MESSAGE CALLED');

        mqttService.handleMessage(
          topic: topic,
          payload: payload,
        );
      } catch (e, s) {
        print('MQTT message error: $e');
        print(s);
      }
    });
  }

  void _onDisconnected() {
    print('========================');
    print('MQTT DISCONNECTED');
    print('========================');

    ref
        .read(mqttConnectionProvider.notifier)
        .setConnected(false);
  }
}



// class MqttClientManager {
//   final MqttStreamBridge mqttService;
//   final Ref ref;
//   late MqttServerClient _client;
//
//   MqttClientManager({required this.mqttService, required this.ref});
//
//   Future<void> connect({
//     required String broker,
//     required String clientId,
//     required String patientId,
//     required String sessionId,
//   }) async {
//     _client = MqttServerClient(broker, clientId);
//     _client.logging(on: false);
//     _client.keepAlivePeriod = 20;
//     _client.onDisconnected = _onDisconnected;
//     _client.onConnected = _onConnected;
//
//     final connMessage = MqttConnectMessage()
//         .withClientIdentifier(clientId)
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce);
//
//     _client.connectionMessage = connMessage;
//
//     try {
//       await _client.connect();
//     } catch (e) {
//       _client.disconnect();
//       return;
//     }
//
//     print('MQTT connection status: ${_client.connectionStatus}');
//
//     if (_client.connectionStatus!.state == MqttConnectionState.connected) {
//       _client.subscribe('device/+/sensor/+/data', MqttQos.atLeastOnce);
//
//       _client.updates!.listen((events) {
//         final MqttPublishMessage recMess =
//         events[0].payload as MqttPublishMessage;
//         final payload =
//         MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//         final topic = events[0].topic;
//
//         mqttService.handleMessage(
//           topic: topic,
//           payload: payload,
//           patientId: patientId,
//           sessionId: sessionId,
//         );
//       });
//     }
//   }
//
//   void _onDisconnected() {
//     // optional reconnection logic
//   }
// }
//
// void _onConnected() {
//   ref.read(mqttConnectionProvider.notifier).setConnected(true);
// }
//
// void _onDisconnected() {
//   ref.read(mqttConnectionProvider.notifier).setConnected(false);
// }
//


