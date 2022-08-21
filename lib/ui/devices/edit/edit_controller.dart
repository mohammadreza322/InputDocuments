import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/EditCoolerRequest.dart';
import 'package:chisco/data/data_class/EditPowerRequest.dart';
import 'package:chisco/data/repository/device/device_reposiory_impl.dart';
import 'package:flutter/material.dart';

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
      AddDeviceResponse addDeviceResponse = response.object;
      //notify change
    }
  }

  onCoolerDeleteClicked(String serialNumber) async {
    ChiscoResponse response = await deviceRepository.deleteDevice(serialNumber);
    if (!response.status) {
      return;
    } else {
      AddDeviceResponse addDeviceResponse = response.object;
    }
  }

  onPowerEditClicked(EditPower power) async {
    ChiscoResponse response = await deviceRepository.editPower(power);

    if (!response.status) {
      //Show Error to user
      return;
    } else {
      AddDeviceResponse addDeviceResponse = response.object;
      //notify change
    }
  }

  onDeviceDeleteClicked(String serialNumber) async {
    ChiscoResponse response = await deviceRepository.deleteDevice(serialNumber);
    if (!response.status) {
      return;
    } else {
      AddDeviceResponse addDeviceResponse = response.object;


      Navigator.pop(context);

    }
  }
}
