import 'dart:ui';

import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/EditCoolerRequest.dart';
import 'package:chisco/data/data_class/EditPowerRequest.dart';
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

  onCoolerEditClicked(EditCooler cooler) async {
    ChiscoResponse response = await deviceRepository.editCooler(cooler);

    if (!response.status) {
      //Show Error to user
      return;
    } else {
      Provider.of<AppController>(context,listen: false).refreshData(response.object);
      //notify change

    }
  }

  onPowerEditClicked(EditPower power) async {
    ChiscoResponse response = await deviceRepository.editPower(power);

    if (!response.status) {
      //Show Error to user
      return;
    } else {
      AddDeviceResponse addDeviceResponse= response.object;
      Provider.of<AppController>(context,listen: false).refreshData(addDeviceResponse);
      Navigator.pop(context);
      //notify change

      ChiscoFlushBar.showFlushBar(context, 'Title',addDeviceResponse.message);


    }
  }

  onDeviceDeleteClicked(String serialNumber) async {
    ChiscoResponse response = await deviceRepository.deleteDevice(serialNumber);
    if (!response.status) {
      return;
    } else {
      Provider.of<AppController>(context,listen: false).refreshData(response.object);
      Navigator.pushNamed(context, homePage);
    }
  }
}
