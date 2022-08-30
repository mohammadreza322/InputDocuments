// ignore_for_file: file_names

import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

MqttClient makeClient(String url, String clientId) =>
    MqttBrowserClient.withPort(url, clientId, 8885);
