import 'dart:async';

import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/ui/devices/cooler/widgets/cooler_mode.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CoolerModes { auto, cold, warm, fan }

class CoolerController extends ChangeNotifier {
  final BuildContext context;
  CoolerController(this.context);

  late Cooler selectedCooler;
  int temp=22;
  CoolerModes coolerMode = CoolerModes.auto;
  String verticalString = '';
  String horizontalString = '';
  String fanSpeedString = '';
  int hourToSleepValue = 0;
  String hourToSleepTitle = '';
  int fanIndex = 0;
  int horizontalIndex = 0;
  int verticalIndex = 0;
  bool initCall = true;
  Timer? timer;

  List<Map<String, String>> fans = [
    {'key': 'Low', 'value': 'کم'},
    {'key': 'Mid', 'value': 'متوسط'},
    {'key': 'High', 'value': 'زیاد'},
    {'key': 'Auto', 'value': 'خودکار'}
  ];
  List<Map<String, String>> swings = [
    {'key': 'Lowest', 'value': 'خیلی کم'},
    {'key': 'Low', 'value': 'کم'},
    {'key': 'Mid', 'value': 'متوسط'},
    {'key': 'High', 'value': 'زیاد'},
    {'key': 'Highest', 'value': 'خیلی زیاد'},
    {'key': 'Auto', 'value': 'خودکار'}
  ];
  initTemp(Cooler selectedCooler){
    initCall=false;
    temp = selectedCooler.temp;
  }
  init(Cooler selectedCooler) {
    AppController appController = Provider.of<AppController>(context,listen: false);
    appController.setContext(context);

    this.selectedCooler = selectedCooler;
    fanSpeedString = fans.firstWhere(
        (element) => element['key'] == selectedCooler.fan)['value']!;
    verticalString = swings.firstWhere(
        (element) => element['key'] == selectedCooler.verticalSwing)['value']!;
    horizontalString = swings.firstWhere((element) =>
        element['key'] == selectedCooler.horizontalSwing)['value']!;
    temp = selectedCooler.temp;
    print(selectedCooler.temp);
    switch(selectedCooler.mode){
      case 'auto':
        coolerMode = CoolerModes.auto;
        break;
      case 'cold':
        coolerMode =CoolerModes.cold;
        break;
      case 'warm':
        coolerMode =CoolerModes.warm;
        break;
      case 'fan':
        coolerMode =CoolerModes.fan;
        break;
      default :
        coolerMode = CoolerModes.auto;
        break;
    }
    print(selectedCooler.timer);
    if (selectedCooler.timer == 'Off') {
      hourToSleepTitle = 'زمان سنج خاموش است';
      hourToSleepValue = 0;
      print('Off');
    } else {
      hourToSleepValue = int.parse(selectedCooler.timer);
      hourToSleepTitle = '$hourToSleepValue ساعت تا خاموشی';
      print('not off');
    }
  }

  changeSelectedCoolerMode(CoolerModes state) {
    timer?.cancel();
    coolerMode = state;
    selectedCooler.mode = state.name;
    setTimer();
    notifyListeners();
  }

  bool changeCoolerStateMode(CoolerModes type) {
    return coolerMode == type;
  }

  changeCoolerActive() {
    selectedCooler.power = !selectedCooler.power;
    if(!selectedCooler.power)
      selectedCooler.timer = 'Off';
    Provider.of<AppController>(context, listen: false).setCooler(selectedCooler);
    bool result = Provider.of<AppController>(context, listen: false).publishCoolerMqtt(selectedCooler,context);

    notifyListeners();
  }

  changeHorizontalString() {
    timer?.cancel();

    horizontalIndex++;
    if (horizontalIndex > 5) {
      horizontalIndex = 0;
    }
    horizontalString = swings[horizontalIndex]['value']!;
    selectedCooler.horizontalSwing = swings[horizontalIndex]['key']!;
    setTimer();
    notifyListeners();
  }

  changeVerticalString() {
    timer?.cancel();

    verticalIndex++;
    if (verticalIndex > 5) {
      verticalIndex = 0;
    }
    verticalString = swings[verticalIndex]['value']!;
    selectedCooler.verticalSwing = swings[verticalIndex]['key']!;
    setTimer();
    notifyListeners();
  }

  changeFanSpeedString() {

    timer?.cancel();
    fanIndex++;
    if (fanIndex > 3) {
      fanIndex = 0;
    }
    fanSpeedString = fans[fanIndex]['value']!;
    selectedCooler.fan = fans[fanIndex]['key']!;
    setTimer();
    notifyListeners();
  }

  changeHourToSleepIncrease() {
    timer?.cancel();
    hourToSleepValue++;
    hourToSleepTitle = '$hourToSleepValue ساعت تا خاموشی';
    selectedCooler.timer = hourToSleepValue.toString();
    setTimer();
    notifyListeners();
  }

  changeHourToSleepDecrease() {
    timer?.cancel();
    print('before If : $hourToSleepValue');
    if (hourToSleepValue > 0) {
      hourToSleepValue--;
      print('Value $hourToSleepValue');
      if (hourToSleepValue != 0) {
        hourToSleepTitle = '$hourToSleepValue ساعت تا خاموشی';
        selectedCooler.timer = hourToSleepValue.toString();
      } else {
        print("ELSE $hourToSleepValue");
        hourToSleepValue =0;
        hourToSleepTitle = 'زمان سنج خاموش است';
        selectedCooler.timer = "Off";
      }
      print(hourToSleepTitle);

    }

    print("Before SetTimer Timer : ${hourToSleepValue}");

    setTimer();

    notifyListeners();
  }

  setTimer() {
    print("Set SetTimer : ${selectedCooler.timer}");
    timer = Timer(const Duration(seconds: 2), () {
      Provider.of<AppController>(context, listen: false).setCooler(selectedCooler);
      Provider.of<AppController>(context, listen: false).publishCoolerMqtt(selectedCooler,context);
    });
  }

  void changeTemp(double temp) {
    timer?.cancel();
    selectedCooler.temp = temp.toInt();
    this.temp = temp.toInt();
    setTimer();
    notifyListeners();
  }
}
