// ignore_for_file: file_names

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
///this method is for creating a connection in Mobile to  MQTT
MqttClient makeClient(String url, String clientId) {
  var client = MqttServerClient.withPort(url, clientId, 8888);
  // client.useWebSocket = true;
  return client;
}
