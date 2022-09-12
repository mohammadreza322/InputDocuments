// ignore_for_file: file_names

import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

///this method is for connecting to  MQTT in web applications
MqttClient makeClient(String url, String clientId) =>
    MqttBrowserClient.withPort("$url/mqtt", clientId, 8083);
