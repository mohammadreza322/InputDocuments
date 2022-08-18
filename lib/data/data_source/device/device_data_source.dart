import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';

abstract class DeviceDataSource {
  Future<ChiscoResponse> addCooler(AddCooler cooler);

  Future<ChiscoResponse> addPower(AddPower power);

  Future<ChiscoResponse> deletePower();

  Future<ChiscoResponse> deleteCooler();

  Future<ChiscoResponse> editPower();

  Future<ChiscoResponse> editCooler();

}
