import 'dart:convert';

import 'package:chisco/http_client/mqtt/mqtt_classes/MqttClientFactory.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';

class MqttController extends ChangeNotifier{
    final BuildContext context;

  MqttController(this.context);

  connect({String? topicForSubscribe}) async {
    //MqttClient client = MqttServerClient.withPort('mqtt://chisco.tech', '',8885);
    /*MqttClient client = makeClient('mqtt://chisco.tech', 'gdfsg');
    client.websocketProtocols = ['mqtt'];*/
    print('controller');
    AppController appController = Provider.of<AppController>(context,listen: false);
    MqttClient client = MqttServerClient.withPort('mqtt://chisco.tech','gdfsg',8885);

    client.logging(on: true);

    final connMessage = MqttConnectMessage()
        .authenticateAs('mehdi1', '1234')
        .withClientIdentifier('Chisco_${appController.getUserDetail().phoneNumber}_${kIsWeb ? 'pwa' : 'mobile'}')
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;
    try {
      client.autoReconnect = true;
      await client.connect();
      print('log');
      client.logging(on: true);
      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        client.updates!.listen(mqttListen);
        final builder = MqttClientPayloadBuilder();
        builder.addString(appController.getUserDetail().phoneNumber);
        client.publishMessage('chisco/test',MqttQos.atLeastOnce,builder.payload!);
      }

    } catch (e) {
      print('MqttError $e');
      client.disconnect();
    }

    //mqttClient = client;
  }

  mqttListen(List<MqttReceivedMessage<MqttMessage?>>? c) {
    if (c != null) {
      // print(c);
      final recMess = c[0].payload as MqttPublishMessage;
      final payloadString = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      try {
        final payload = jsonDecode(payloadString);
        // print(payload);
        final topic = c[0].topic;
        RegExp regExp = RegExp(r'/VIAQ/(.*)');
        var matches = regExp.allMatches(topic);

        var serialNumber = matches.first.group(1);

        print('serialNumber : $serialNumber');
        notifyListeners();
      } on FormatException {
        // print(e);
        print('The provided string is not valid JSON');
      }
    }
  }


  publishMessage(){

  }
}