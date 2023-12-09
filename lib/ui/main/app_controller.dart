import 'dart:convert';

import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
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

  BuildContext? context;

  setContext(BuildContext context) {
    this.context = context;
  }

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
    //print('set Data from app controller');
    // print("User Devices from App Controller : ${_user!.devices}");
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
    //print("User Device List : ${_userDevicesList.toString()}");
  }

  ///after any editing in our app such as Add Or Edit Device , Add or Edit Schedule
  ///this method will call and its for updating or refreshing dates
  refreshData(AddDeviceResponse response) {
    // print('****************************');
    _coolers = response.devices.coolers;
    _powers = response.devices.powers;
    _categories = response.devices.categories;
    convertDeviceList();
    //print("refreh data called");
    //print(_userDevicesList);
    notifyListeners();
  }

  ///after editing user detail such as Location birthday or name we refresh User Data With this method
  refreshUserData(
      {required String location, required String name, required num? date}) {
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
    int index = _coolers.indexWhere((element) => element.serialNumber == selectedCooler.serialNumber);

    _coolers[index] = selectedCooler;

    notifyListeners();
  }

  ///this method is for Connect to Mqtt
  connect({String? topicForSubscribe}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(sharedPreferences.getString('detail')!);

    ///we need to decode Mqtt Username and password for connection
    String userNameBroker = decodedToken['usernameBroker'];
    String passwordBroker = decodedToken['passwordBroker'];

    String url = '';

    ///if user use Web App we have to connect mqtt like this ws://[url]
    ///and if user use Mobile we don't need add anything at the start of url
    // if (kIsWeb) {
      url = "wss://";
    // }

    url += "dashboard.chisco.tech";

    //print(
    //    'UserName : ${decodedToken['usernameBroker']}\nPassword: ${decodedToken['passwordBroker']}');

    MqttClient client = makeClient(url, '');
    client.websocketProtocols = ['mqtts', 'mqtt'];

    // client.logging(on: true);
    // client.onDisconnected = () {
    //   print("disConnectttttttttt");
    // };

    // client.onConnected = () {
    //   print("concteeeeeeeeeeed **********************");
    //   // print(client.connectionStatus!.state);
    //   // isMqttConnected = true;
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
        isMqttConnected = true;
        _userDevicesList.forEach((element) {
          client.subscribe(
              '/chisco/${element.serialNumber}/get', MqttQos.atLeastOnce);
          client.subscribe(
              '/connection/${element.serialNumber}', MqttQos.atLeastOnce);
          client.subscribe(
              '/chisco/${element.serialNumber}/change_cooler_model',
              MqttQos.atLeastOnce);
        });
        client.updates!.listen(mqttListen);
        mqttClient = client;
        notifyListeners();
      }
    } catch (e) {
      client.disconnect();
    }
  }

  subscribe(serialNumber) {
    if (mqttClient?.connectionStatus!.state == MqttConnectionState.connected) {
      mqttClient?.subscribe('/chisco/$serialNumber/get', MqttQos.atLeastOnce);
      mqttClient?.subscribe('/connection/${serialNumber}', MqttQos.atLeastOnce);
      mqttClient?.subscribe(
          '/chisco/${serialNumber}/change_cooler_model', MqttQos.atLeastOnce);
    }
  }

  unsubscribe(serialNumber) {
    if (mqttClient?.connectionStatus!.state == MqttConnectionState.connected) {
      mqttClient?.unsubscribe('/chisco/$serialNumber/get');
      mqttClient?.unsubscribe('/connection/${serialNumber}');
      mqttClient?.unsubscribe('/chisco/${serialNumber}/change_cooler_model');
    }
  }

  ///for Subscribe to mqtt or Listen to Received Messages we need this method
  ///our Mqtt send serial Number of Device
  ///we get 2 thing in device
  ///if device is instance of Power we need to update Voltage in view and list
  ///if device is instance of Cooler we need to update Current state of Cooler in both view and list

  mqttListen(List<MqttReceivedMessage<MqttMessage?>>? c) {
    if (c != null) {
      final recMess = c[0].payload as MqttPublishMessage;
      final payloadString = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      try {
        final payload = jsonDecode(payloadString);
        final topic = c[0].topic;

        RegExp connectionRegex = RegExp(r'/connection/(.+)');
        RegExp regExpData = RegExp(r'/chisco/(.*)/get');
        RegExp changeModel = RegExp(r'/chisco/(.*)/change_cooler_model');
        bool hasConnectionRegex = connectionRegex.hasMatch(topic);
        bool hasDataRegex = regExpData.hasMatch(topic);
        bool changeModelRegex = changeModel.hasMatch(topic);
        RegExp? regExp;

        if (hasConnectionRegex) {
          regExp = connectionRegex;
        } else if (hasDataRegex) {
          regExp = regExpData;
        } else if (changeModelRegex) {
          regExp = changeModel;
        }

        var matches = regExp!.allMatches(topic);
        String? serialNumber = matches.first.group(1);

        if (hasConnectionRegex) {
          //todo change device last connection
          // print('Has Connection Regex');
          changeDeviceLastConnection(payload, serialNumber!);
        } else if (hasDataRegex) {
          //todo change device data
          changeDeviceData(payload, serialNumber!);
        } else if (changeModelRegex) {
          changeDeviceModel(payload, serialNumber!);
        }
        notifyListeners();
      } on FormatException {
        // print(e);
        //  print('The provided string is not valid JSON');
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
    // print(mqttClient?.connectionStatus!.state);
    //print()
    if (mqttClient?.connectionStatus!.state == MqttConnectionState.connected) {
      //  print('published');
      // print(topic);
      mqttClient?.publishMessage(topic, MqttQos.exactlyOnce, data.payload!);
    }
  }

  publishPowerMqtt(Power power, BuildContext context) {
    List ports = [];

    power.connectors.forEach((element) {
      Map<String, dynamic> connector = {};
      connector['portNumber'] = element.connectorId;
      connector['status'] = element.status;
      ports.add(connector);
    });

    String port = 'ports:${jsonEncode(ports)}';
    String result = json.encode({"ports": ports});
    print(result);

    if (power.connectionStatus) {
      publishMessage('/chisco/${power.serialNumber}/change', MqttClientPayloadBuilder().addString(result));
      //publishMessage('/chisco/${cooler.serialNumber}/change', MqttClientPayloadBuilder().addString(result));
      // print('TRUE');
      ChiscoFlushBar.showSuccessFlushBar(context, 'تغییرات با موفقیت ثبت شد!');
    } else {
      //print("FALSE");
      ChiscoFlushBar.showErrorFlushBar(
          context, 'دستگاه شما به اینترنت وصل نیست!');
    }
  }

  publishCoolerMqtt(Cooler cooler, BuildContext context) {
    Map<String, dynamic> coolerMap = {};
    coolerMap['status'] = cooler.power;
    coolerMap['temp'] = cooler.temp;
    coolerMap['mode'] = cooler.mode;
    coolerMap['verticalSwing'] = cooler.verticalSwing;
    coolerMap['horizontalSwing'] = cooler.horizontalSwing;
    coolerMap['fan'] = cooler.fan;
    coolerMap['timer'] = cooler.timer;

      String result = json.encode({"cooler": coolerMap});
    //print(cooler.connectionStatus);

    if (cooler.connectionStatus) {
      publishMessage('/chisco/${cooler.serialNumber}/change', MqttClientPayloadBuilder().addString(result));
      print('TRUE');
      //ChiscoFlushBar.showSuccessFlushBar(context, 'تغییرات با موفقیت ثبت شد!');
    } else {
      print("FALSE");
      ChiscoFlushBar.showErrorFlushBar(
          context, 'دستگاه شما به اینترنت وصل نیست!');
    }
  }

  changeDeviceModel(dynamic payload, String serialNumber) {
    ///update coolers
    _coolers.forEach((element) {
      if (element.serialNumber == serialNumber) {
        var model = payload['model'];
        Cooler cooler = getCoolerWithSerialNumber(serialNumber);
        cooler.model = model;

        setCooler(cooler);

        ChiscoFlushBar.showAnotherSucces(context);
      }
    });
  }

  changeDeviceData(dynamic payload, String serialNumber) {
    ///update coolers
    _coolers.forEach((element) {
      if (element.serialNumber == serialNumber) {
        var coolerPayload = payload['cooler'];
        Cooler cooler = getCoolerWithSerialNumber(serialNumber);
        cooler.timer = coolerPayload['timer'];
        cooler.mode = coolerPayload['mode'];
        cooler.horizontalSwing = coolerPayload['horizontalSwing'];
        cooler.verticalSwing = coolerPayload['verticalSwing'];
        cooler.fan = coolerPayload['fan'];
        cooler.temp = coolerPayload['temp'];
        cooler.power = coolerPayload['status'];
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
              (element) => element['portNumber'] == connector.connectorId)['status'];

          connector.status = status;
          connectors.add(connector);
        }

        Power power = getPowerWithSerialNumber(serialNumber);
        power.connectors = connectors;
        power.totalVoltage = payload['totalVoltage'] ?? 0;

        setPower(power);
      }
    });
  }

  changeDeviceLastConnection(dynamic payload, String serialNumber) {
    _coolers.forEach((element) {
      if (element.serialNumber == serialNumber) {
        Cooler cooler = getCoolerWithSerialNumber(serialNumber);
        cooler.connectionStatus = payload['connectionStatus'];
        setCooler(cooler);
      }
    });
    _powers.forEach((element) {
      if (element.serialNumber == serialNumber) {
        Power power = getPowerWithSerialNumber(serialNumber);
        power.connectionStatus = payload['connectionStatus'];
        setPower(power);
      }
    });
  }

  updatePowersConnectors(Power selectedPower, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> data = [];
    // selectedPower.isPowerActive
    if (selectedPower.isPowerActive) {
      //  print('isPowerActive is TRUE');
      for (var element in selectedPower.connectors) {
        //print("Element Status :${element.status}");
        data.add(
            {'connectorId': element.connectorId, 'status': element.status});

        ///save state in sharePreferences
        sharedPreferences.setString(
            selectedPower.serialNumber, jsonEncode(data));

        element.status = false;
      }
    } else {
      // print('isPowerActive is FALSE');
      if (!sharedPreferences.containsKey(selectedPower.serialNumber)) {
        for (var element in selectedPower.connectors) {
          element.status = true;
        }
      } else {
        //print('Else');
        String? data = sharedPreferences.getString(selectedPower.serialNumber);

        ///read data from sharepref to update connectors
        List result = jsonDecode(data!);
        for (Connector element in selectedPower.connectors) {
          for (Map<String, dynamic> connector in result) {
            if (connector['connectorId'] == element.connectorId) {
              element.status = connector['status'];
              break;
            }
          }
        }
      }
    }
    setPower(selectedPower);
    // print('is Power Active :: ${selectedPower.isPowerActive()}');
    selectedPower.isPowerActive = !selectedPower.isPowerActive;
    //isPowerActive = !isPowerActive;

    publishPowerMqtt(selectedPower, context);
    // print("################################");
    notifyListeners();
  }
}
