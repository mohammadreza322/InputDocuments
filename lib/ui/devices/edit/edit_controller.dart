import 'dart:ui';

import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/EditCoolerRequest.dart';
import 'package:chisco/data/data_class/EditPowerRequest.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/data/repository/device/device_reposiory_impl.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDeviceController extends ChangeNotifier {
  final BuildContext context;
  DeviceRepositoryImpl deviceRepository = DeviceRepositoryImpl();
  EditDeviceController(this.context);

  bool isPageLoading = false;
  final TextEditingController brandTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController categoryTextController = TextEditingController();
  final TextEditingController powerOutletFirst = TextEditingController();
  final TextEditingController powerOutletSecond = TextEditingController();
  final TextEditingController powerOutletThird = TextEditingController();
  final TextEditingController powerOutletFourth = TextEditingController();
  final TextEditingController usbPortFirst = TextEditingController();
  final TextEditingController usbPortSecond = TextEditingController();
  init(Device device){
    isPageLoading = true;
    print(nameTextController.text);
    if(device.deviceType ==DeviceType.cooler){
      Cooler cooler = device as Cooler;
      nameTextController.text = cooler.name;
      categoryTextController.text  = cooler.category;
      brandTextController.text = cooler.brand;
    }
    else{
      Power power = device as Power;
      nameTextController.text = power.name;
      categoryTextController.text = power.category;
      powerOutletFirst.text = power.connectors[0].name;
      powerOutletSecond.text = power.connectors[1].name;
      powerOutletThird.text = power.connectors[2].name;
      powerOutletFourth.text = power.connectors[3].name;
      usbPortFirst.text = power.connectors[4].name;
      usbPortSecond.text = power.connectors[5].name;

    }
  }
  onCoolerEditClicked(EditCooler cooler) async {
    ChiscoResponse response = await deviceRepository.editCooler(cooler);

    if (!response.status) {
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
      return;
    } else {
      AddDeviceResponse addDeviceResponse =response.object;

      Navigator.pop(context);
      ChiscoFlushBar.showSuccessFlushBar(context, addDeviceResponse.message);

      Provider.of<AppController>(context,listen: false).refreshData(addDeviceResponse);
      //notify change

    }
  }

  onPowerEditClicked(EditPower power) async {
    ChiscoResponse response = await deviceRepository.editPower(power);

    if (!response.status) {
      //Show Error to user
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);

      return;
    } else {

      AddDeviceResponse addDeviceResponse =response.object;
      Navigator.pop(context);

      ChiscoFlushBar.showSuccessFlushBar(context, addDeviceResponse.message);
      Provider.of<AppController>(context,listen: false).refreshData(addDeviceResponse);
      //notify change

      ChiscoFlushBar.showSuccessFlushBar(context,addDeviceResponse.message);


    }
  }

  onDeviceDeleteClicked(String serialNumber) async {
    ChiscoResponse response = await deviceRepository.deleteDevice(serialNumber);
    if (!response.status) {
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
      print(response.errorMessage);
      return;
    } else {
      AddDeviceResponse addDeviceResponse =response.object;
      print(addDeviceResponse.message);
      Navigator.pushNamed(context, homePage);
      ChiscoFlushBar.showSuccessFlushBar(context, addDeviceResponse.message);

      Provider.of<AppController>(context,listen: false).refreshData(addDeviceResponse);

    }
  }
}
