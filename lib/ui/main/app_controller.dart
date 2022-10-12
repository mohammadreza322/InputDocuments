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

///AppController is Provider Controller class for Base functions or Common functions in our Project
///we Store all Lists and UserDetail here
///and if somewhere we need something we have Access to it
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

  ///after user login or splash screen and after we send request to server for getting dates
  ///this method will call and its for setting data in appController
  ///its a setter for all data we have
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

  ///if user didn't add any device its return false for else it's return true
  ///in the Screen if this function return false we show EmptyState for else we show list
  isUserHaveDevice() {
    if (_coolers.length == 0 && _powers.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  ///we have 2 type of list
  ///Cooler and Powers
  ///in this method we combine these to one
  convertDeviceList() {
    _userDevicesList = List.from(_powers)..addAll(_coolers);
    print("User Device List : ${_userDevicesList.toString()}");
  }

  ///after any editing in our app such as Add Or Edit Device , Add or Edit Schedule
  ///this method will call and its for updating or refreshing dates
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

  ///after editing user detail such as Location birthday or name we refresh User Data With this method
  refreshUserData(
      {required String location, required String name, required num date}) {
    _user!.userDetail.address = location;
    _user!.userDetail.birthday = date;
    _user!.userDetail.fullName = name;

    notifyListeners();
  }

  ///we find Cooler in our list with serial Number and we return the Cooler
  Cooler getCoolerWithSerialNumber(String serialNumber) {
    final index =
        _coolers.indexWhere((element) => element.serialNumber == serialNumber);
    return _coolers[index];
  }

  ///we find Power in our list with serial Number and we return the Power
  Power getPowerWithSerialNumber(String serialNumber) {
    final index =
        _powers.indexWhere((element) => element.serialNumber == serialNumber);
    return _powers[index];
  }

  ///we find Device in our list with serial Number and we return the Device
  Device getDeviceWithSerialNumber(String serialNumber) {
    final index = _userDevicesList
        .indexWhere((element) => element.serialNumber == serialNumber);
    return _userDevicesList[index];
  }

  ///we update power with this method
  ///first we find it in list and then we replace it
  setPower(Power power) {
    int index = _powers
        .indexWhere((element) => element.serialNumber == power.serialNumber);
    _powers[index] = power;

    //publishPowerMqtt(power);

    notifyListeners();
  }

  setCooler(Cooler selectedCooler) {
    int index = _coolers.indexWhere(
        (element) => element.serialNumber == selectedCooler.serialNumber);
    _coolers[index] = selectedCooler;

    notifyListeners();
  }

  ///this method is for Connect to Mqtt
  connect({String? topicForSubscribe}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(sharedPreferences.getString('detail')!);

    ///we need to decode Mqtt Username and password for connection
    String userNameBroker = decodedToken['usernameBroker'];
    String passwordBroker = decodedToken['passwordBroker'];

    String url = '';

    ///if user use Web App we have to connect mqtt like this ws://[url]
    ///and if user use Mobile we don't need add anything at the start of url
    if (kIsWeb) {
      url = "wss://";
    }

    url += "chisco.tech";
    print(
        'UserName : ${decodedToken['usernameBroker']}\nPassword: ${decodedToken['passwordBroker']}');

    MqttClient client = makeClient(url, '');
    client.websocketProtocols = ['mqtts', 'mqtt'];

    //client.logging(on: true);
    // client.onDisconnected = () {
    //   print("disConnectttttttttt");
    // };

    // client.onConnected = () {
    //   // print("concteeeeeeeeeeed **********************");
    //   // print(client.connectionStatus!.state);
    //   isMqttConnected = true;
    //   //notifyListeners();
    // };
    final connMessage = MqttConnectMessage()
        .authenticateAs(userNameBroker, passwordBroker)
        .withClientIdentifier(
            'Chisco_${getUserDetail().phoneNumber}_${kIsWeb ? 'pwa' : 'mobile'}')
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;
    try {
      client.autoReconnect = true;
      client.keepAlivePeriod = 20000;

      client.logging(on: false);
      await client.connect(userNameBroker, passwordBroker);

      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        print("connectedddddddd");
        print("******************");
        isMqttConnected = true;
        //for device
        _userDevicesList.forEach((element) {
          client.subscribe(
              '/chisco/${element.serialNumber}/get', MqttQos.atLeastOnce);
          // print("Meti ::");
          print("subscribe '/chisco/${element.serialNumber}'");
        });
        client.updates!.listen(mqttListen);
        mqttClient = client;
        notifyListeners();
      }
    } catch (e) {
      print('MqttError $e');
      client.disconnect();
    }
  }

  subscribe(serialNumber) {
    if (mqttClient?.connectionStatus!.state == MqttConnectionState.connected) {
      mqttClient?.subscribe('/chisco/$serialNumber/get', MqttQos.atLeastOnce);
    }
  }

  unsubscribe(serialNumber) {
    if (mqttClient?.connectionStatus!.state == MqttConnectionState.connected) {
      mqttClient?.unsubscribe('/chisco/$serialNumber/get');
    }
  }

  ///for Subscribe to mqtt or Listen to Received Messages we need this method
  ///our Mqtt send serial Number of Device
  ///we get 2 thing in device
  ///if device is instance of Power we need to update Voltage in view and list
  ///if device is instance of Cooler we need to update Current state of Cooler in both view and list

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

        ///here we find serial Number

        RegExp regExp = RegExp(r'/chisco/(.*)/get');
        var matches = regExp.allMatches(topic);
        String? serialNumber = matches.first.group(1);
        print("ok1");
        print(serialNumber);
        print(payload);

        ///update coolers
        _coolers.forEach((element) {
          if (element.serialNumber == serialNumber) {
            Cooler cooler = getCoolerWithSerialNumber(serialNumber!);
            cooler.timer = payload['timer'];
            cooler.mode = payload['mode'];
            cooler.horizontalSwing = payload['horizontalSwing'];
            cooler.verticalSwing = payload['verticalSwing'];
            cooler.fan = payload['fan'];
            cooler.temp = payload['temp'];
            cooler.power = payload['status'];

            setCooler(cooler);
          }
        });

        ///update powers

        _powers.forEach((element) {
          print(element.serialNumber);
          if (element.serialNumber == serialNumber) {
            List<Connector> connectors = [];
            for (int i = 0; i < element.connectors.length; i++) {
              Connector connector = element.connectors[i];
              bool status = (payload['ports'] as List<dynamic>).singleWhere(
                  (element) =>
                      element['portNumber'] == connector.connectorId)['status'];
              connector.status = status;
              connectors.add(connector);
            }

            Power power = getPowerWithSerialNumber(serialNumber!);
            power.connectors = connectors;
            power.totalVoltage = payload['totalVoltage'] ?? 0;

            print('set power');
            setPower(power);
          }
        });

        notifyListeners();
      } on FormatException {
        // print(e);
        print('The provided string is not valid JSON');
      }
    }
  }

  ///this function is for publish or send message to mqtt
  publishMessage(String topic, MqttClientPayloadBuilder data) async {
    if (data.payload == null) {
      data.addString({"chisco": true}.toString());
    }

    // if (mqttClient == null) {
    //   await connect();
    // }
    print(mqttClient?.connectionStatus!.state);
    if (mqttClient?.connectionStatus!.state == MqttConnectionState.connected) {
      print('published');
      print(topic);
      mqttClient?.publishMessage(topic, MqttQos.exactlyOnce, data.payload!);
    }
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
    coolerMap['verticalSwing'] = cooler.verticalSwing;
    coolerMap['horizontalSwing'] = cooler.horizontalSwing;
    coolerMap['fan'] = cooler.fan;
    coolerMap['timer'] = cooler.timer;

    String result = json.encode({"cooler": coolerMap});
    publishMessage('/chisco/${cooler.serialNumber}/change',
        MqttClientPayloadBuilder().addString(result));
  }
}
