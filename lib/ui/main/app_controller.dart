import 'dart:convert';

import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../http_client/mqtt/mqtt_classes/MqttClientFactory.dart';

class AppController extends ChangeNotifier {
  User? _user;

  List<Cooler> _coolers = [];

  List<Power> _powers = [];

  List<String> _categories = [];

  List<Device> _userDevicesList = [];
  MqttClient? mqttClient;

  bool isAppLoaded = false;
  bool isMqttConnected = false;
  UserDetail getUserDetail() {
    return _user!.userDetail;
  }

  List<Cooler> getCoolers() => _coolers;

  List<Power> getPowers() => _powers;

  User? getUser() => _user;

  get getCategories => _categories;

  get getUserDevicesList => _userDevicesList;


  setData(User value) {
    _user = value;
    _categories = _user!.devices.categories;
    _coolers = _user!.devices.coolers;
    _powers = _user!.devices.powers;
    print('set Data from app controller');
    print("User Devices from App Controller : ${_user!.devices}");
    convertDeviceList();
    notifyListeners();
  }
  isUserHaveDevice() {
    if (_coolers.length == 0 && _powers.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  convertDeviceList() {
    _userDevicesList = List.from(_powers)
      ..addAll(_coolers);
    print("User Device List : ${_userDevicesList.toString()}");
  }

  refreshData(AddDeviceResponse response) {
    print('****************************');
    _coolers = response.devices.coolers;
    _powers = response.devices.powers;
    _categories = response.devices.categories;
    convertDeviceList();
    print("refreh data called");
    print(_userDevicesList);
    notifyListeners();
  }

  refreshUserData({required String location, required String name, required num date}){
    _user!.userDetail.address =location;
    _user!.userDetail.birthday = date;
    _user!.userDetail.fullName = name;


    notifyListeners();
  }


  Cooler getCoolerWithSerialNumber(String serialNumber) {
    final index =
    _coolers.indexWhere((element) => element.serialNumber == serialNumber);
    return _coolers[index];
  }

  Power getPowerWithSerialNumber(String serialNumber) {
    final index =
    _powers.indexWhere((element) => element.serialNumber == serialNumber);
    return _powers[index];
  }

  Device getDeviceWithSerialNumber(String serialNumber) {
    final index = _userDevicesList
        .indexWhere((element) => element.serialNumber == serialNumber);
    return _userDevicesList[index];
  }

  setPower(Power power) {
    int index = _powers
        .indexWhere((element) => element.serialNumber == power.serialNumber);
    _powers[index] = power;

    //publishPowerMqtt(power);

    notifyListeners();
  }

  connect({String? topicForSubscribe}) async {
    //MqttClient client = MqttServerClient.withPort('mqtt://chisco.tech', '',8885);
    //MqttClient client = makeClient('mqtt://chisco.tech', 'gdfsg');
    print('controller');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(sharedPreferences.getString('detail')!);
    String userNameBroker = decodedToken['usernameBroker'];
    String passwordBroker = decodedToken['passwordBroker'];

    String url ='';

    if(kIsWeb) {
      url = "ws://";
    }

    url+="chisco.tech";
    print('UserName : ${decodedToken['usernameBroker']}\nPassword: ${decodedToken['passwordBroker']}');
    MqttClient client = makeClient(url, '');
    client.websocketProtocols = ['mqtts','mqtt'];

    //client.logging(on: true);
    client.onDisconnected=(){
      print("disConnectttttttttt");

    };

    client.onConnected=(){
      //print("concteeeeeeeeeeed");
      isMqttConnected = true;
      notifyListeners();

    };
    final connMessage = MqttConnectMessage()
        .authenticateAs(userNameBroker, passwordBroker)
        .withClientIdentifier('Chisco_${getUserDetail().phoneNumber}_${kIsWeb ? 'pwa' : 'mobile'}')
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;
    try {
      client.autoReconnect = true;
      client.logging(on: false);
      await client.connect();

      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        //for device
        _userDevicesList.forEach((element) {
          client.subscribe('/chisco/${element.serialNumber}/get', MqttQos.atLeastOnce);
         // print("Meti ::");
          //print("subscribe '/chisco/${element.serialNumber}'");
        });
        client.updates!.listen(mqttListen);
      }
    } catch (e) {
      print('MqttError $e');
      client.disconnect();
    }

    mqttClient = client;
  }

  mqttListen(List<MqttReceivedMessage<MqttMessage?>>? c) {
   //print('hjjhj');
   //print(c);
    if (c != null) {
      final recMess = c[0].payload as MqttPublishMessage;
      final payloadString =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      try {
        final payload = jsonDecode(payloadString);
        final topic = c[0].topic;
        RegExp regExp = RegExp(r'/chisco/(.*)');
        var matches = regExp.allMatches(topic);
        String? serialNumber = matches.first.group(1);

        _coolers.forEach((element) {

          if (element.serialNumber == serialNumber) {
            Cooler cooler = getCoolerWithSerialNumber(serialNumber!);
            cooler.timer = payload['timer'];
            cooler.mode = payload['mode'];
            cooler.horizontalSwing = payload['horizontalSwing'];
            cooler.verticalSwing = payload['verticalSwing'];
            cooler.fan = payload['fan'];
            cooler.temp = payload['temp'];
            setCooler(cooler);
          }
        });

        _powers.forEach((element) {
          print(element.serialNumber);
          if (element.serialNumber == serialNumber) {

            List<Connector> connectors = [];
            for (int i = 0; i < element.connectors.length; i++) {
              Connector connector = element.connectors[i];
              bool status = (payload['connectors'] as List<dynamic>).singleWhere((
                  element) => element['portNumber'] == connector.connectorId)['status'];
              connector.status = status;
              connectors.add(connector);
            }

            Power power = getPowerWithSerialNumber(serialNumber!);
            power.connectors = connectors;
            power.totalVoltage = payload['totalVoltage'];

            print('set power');
            setPower(power);
          }
        });

        print(serialNumber);

        notifyListeners();
      } on FormatException {
        // print(e);
        print('The provided string is not valid JSON');
      }
    }
  }

  publishMessage(String topic, MqttClientPayloadBuilder data) {
    if (data.payload == null) {
      data.addString({"chisco": true}.toString());
    }


    print('published');
    mqttClient?.publishMessage(topic, MqttQos.exactlyOnce, data.payload!);
  }

  setCooler(Cooler selectedCooler) {
    int index = _coolers.indexWhere(
            (element) => element.serialNumber == selectedCooler.serialNumber);
    _coolers[index] = selectedCooler;

    notifyListeners();
  }

  publishPowerMqtt(Power power) {
    List ports = [];

    power.connectors.forEach((element) {
      Map<String, dynamic> connector = {};
      connector['portNumber'] = element.connectorId;
      connector['status'] = element.status;
      ports.add(connector);
    });

    String port = 'ports:${jsonEncode(ports)}';
    String result = json.encode({"ports": ports});

    publishMessage('/chisco/${power.serialNumber}/change',
        MqttClientPayloadBuilder().addString(result));
  }

  publishCoolerMqtt(Cooler cooler) {
    Map<String, dynamic> coolerMap = {};
    coolerMap['status'] = cooler.power;
    coolerMap['temp'] = cooler.temp;
    coolerMap['mode'] = cooler.mode;
    coolerMap['vertical_swing'] = cooler.verticalSwing;
    coolerMap['horizontal_swing'] = cooler.horizontalSwing;
    coolerMap['fan'] = cooler.fan;
    coolerMap['timer'] = cooler.timer;


    String result = json.encode({"cooler": coolerMap});
    publishMessage('/chisco/${cooler.serialNumber}/change', MqttClientPayloadBuilder().addString(result));
  }
}
