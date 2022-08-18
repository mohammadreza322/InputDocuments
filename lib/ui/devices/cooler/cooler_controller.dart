import 'package:chisco/ui/devices/cooler/widgets/cooler_state.dart';
import 'package:flutter/material.dart';

enum CoolerStates { auto, cold, warm, fan }

class CoolerController extends ChangeNotifier {
final BuildContext context;

  CoolerStates coolerState = CoolerStates.auto;

  CoolerController(this.context);

  changeSelectedCoolerState(CoolerStates state){
    coolerState =state;
    notifyListeners();

  }
  bool changeCoolerStateCompareItems(CoolerStates type){
    return coolerState==type;
  }


}
