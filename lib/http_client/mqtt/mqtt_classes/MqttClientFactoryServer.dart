// ignore_for_file: file_names

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
///this method is for connecting to  MQTT in Mobile
MqttClient makeClient(String url, String clientId) {
  var client = MqttServerClient.withPort(url, clientId, 1883);
  // client.useWebSocket = true;
  return client;
}