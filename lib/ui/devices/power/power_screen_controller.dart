import 'dart:async';
import 'dart:convert';

import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class PowerController extends ChangeNotifier {
  final BuildContext context;

  PowerController(this.context);

  late bool isPowerActive;
  int voltage = 120;
  bool initCall = true;

  late Power selectedPower;

  init(Power selectedPower) {
    initCall = false;
    AppController appController = Provider.of<AppController>(context,listen: false);
    appController.setContext(context);
   // List<Connector> connectors = selectedPower.connectors.where((element) => element.status).toList();
    voltage = selectedPower.totalVoltage;
   /* if (connectors.isEmpty) {
      isPowerActive = false;
    } else {
      isPowerActive = true;
    }*/
    print('init');
    selectedPower.checkIsPowerActive();
    //isPowerActive=selectedPower.isPowerActive();
    this.selectedPower = selectedPower;
    Timer(Duration(milliseconds: 250),() {
      notifyListeners();
    });
  }

  onPowerBtnClicked({required Power selectedPower}) async {
    await Provider.of<AppController>(context,listen: false).updatePowersConnectors(selectedPower,context);
    notifyListeners();
  }

  onConnectorChange(connectorId, status) async{
    List<Connector> connectors = selectedPower.connectors.where((element) => element.status).toList();
    print(connectors.length);
    print(status);
    if(!status&& connectors.length==1){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove(selectedPower.serialNumber);

    }
      int index = selectedPower.connectors.indexWhere((element) => element.connectorId == connectorId);
      print("<><><><><><><><><><>");
      print("index : ");
      print(index);
      selectedPower.connectors[index].status = status;
      print(selectedPower.connectors[index].status);
      Provider.of<AppController>(context, listen: false).setPower(selectedPower);
      Provider.of<AppController>(context, listen: false).publishPowerMqtt(selectedPower, context);
      init(selectedPower);
      notifyListeners();



  }

}

class PowerItem {
  final String title;
  final String description;
  final String icon;
  final bool isOn;

  PowerItem(
      {required this.title,
      required this.description,
      required this.icon,
      required this.isOn});
}


