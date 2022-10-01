import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/EditCoolerRequest.dart';
import 'package:chisco/data/data_class/EditPowerRequest.dart';
///interface of data source for device functions

abstract class DeviceDataSource {
  ///adding cooler function @params AddCooler
  Future<ChiscoResponse> addCooler(AddCooler cooler);
  ///adding power function

  Future<ChiscoResponse> addPower(AddPower power);

  ///deleting device with serialNumber
  Future<ChiscoResponse> deleteDevice(String serialNumber);
  ///Edit Power
  Future<ChiscoResponse> editPower(EditPower power);
  ///Edit Cooler
  Future<ChiscoResponse> editCooler(EditCooler cooler);

}
