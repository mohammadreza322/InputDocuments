import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/EditCoolerRequest.dart';
import 'package:chisco/data/data_class/EditPowerRequest.dart';

abstract class DeviceDataSource {
  Future<ChiscoResponse> addCooler(AddCooler cooler);

  Future<ChiscoResponse> addPower(AddPower power);

  Future<ChiscoResponse> deleteDevice(String serialNumber);


  Future<ChiscoResponse> editPower(EditPower power);

  Future<ChiscoResponse> editCooler(EditCooler cooler);

}
