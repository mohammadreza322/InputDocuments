import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PowerController extends ChangeNotifier {
  final BuildContext context;

  PowerController(this.context);

  late bool isPowerActive;
  int voltage =120;
  bool initCall = true;

  late Power selectedPower;


  init(Power selectedPower) {
    initCall = false;
    List<Connector> connectors = selectedPower.connectors.where((element) => element.status).toList();
    voltage = selectedPower.totalVoltage;
    if (connectors.isEmpty){
      isPowerActive=false;
    }else{
      isPowerActive= true;
    }
    this.selectedPower = selectedPower;
  }

  onPowerBtnClicked({required Power selectedPower}) {
    selectedPower.connectors.forEach((element) {
      element.status = !isPowerActive;
    });

    Provider.of<AppController>(context,listen: false).setPower(selectedPower);
    isPowerActive = !isPowerActive;
    Provider.of<AppController>(context,listen: false).publishPowerMqtt(selectedPower);
    notifyListeners();

  }

  onConnectorChange(connectorId,status) {
    int index= selectedPower.connectors.indexWhere((element) => element.connectorId == connectorId);
    selectedPower.connectors[index].status = status;
    print(selectedPower.connectors);
    Provider.of<AppController>(context,listen: false).setPower(selectedPower);
    Provider.of<AppController>(context,listen: false).publishPowerMqtt(selectedPower);

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
