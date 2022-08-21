import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/EditCoolerRequest.dart';
import 'package:chisco/data/data_class/EditPowerRequest.dart';

abstract class DeviceRepository{
  Future<ChiscoResponse> addCooler(AddCooler cooler);

  Future<ChiscoResponse> addPower(AddPower power);


  Future<ChiscoResponse> deleteDevice(String serialNumber);


  Future<ChiscoResponse> editCooler(EditCooler cooler);

  Future<ChiscoResponse> editPower(EditPower power);



}