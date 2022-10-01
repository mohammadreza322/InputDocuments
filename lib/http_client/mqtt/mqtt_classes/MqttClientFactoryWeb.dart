// ignore_for_file: file_names

import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

///this method is for creating a connection in Web App to  MQTT

MqttClient makeClient(String url, String clientId) =>
    MqttBrowserClient.withPort("$url/mqtt", clientId, 8083);
