import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';

abstract class DeviceRepository{
  Future<ChiscoResponse> addCooler(AddCooler cooler);

  Future<ChiscoResponse> addPower(AddPower power);


}