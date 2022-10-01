import 'dart:ui';

import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/EditCoolerRequest.dart';
import 'package:chisco/data/data_class/EditPowerRequest.dart';
import 'package:chisco/data/data_source/device/device_data_source.dart';
import 'package:chisco/http_client/httpService.dart';


///Implementation of DeviceDataSource for sending http request
class DeviceRemoteDataSource extends DeviceDataSource {
  final ChiscoClient client = ChiscoClient();

  @override
  Future<ChiscoResponse> addCooler(AddCooler cooler) async {
    ChiscoResponse chiscoResponse =
        await client.request(url: 'device/save', data: cooler.toJson());
    print(chiscoResponse);
    return chiscoResponse;
  }

  @override
  Future<ChiscoResponse> addPower(AddPower power) async{
  ChiscoResponse response = await client.request(url: 'device/save', data: power.toJson());
  print(response);
  return response;
  }

  @override
  Future<ChiscoResponse> editCooler(EditCooler cooler) async {
    ChiscoResponse response = await client.request(url: 'device/save',data: cooler.toJson());
    return response;
  }

  @override
  Future<ChiscoResponse> editPower(EditPower power) async{
    ChiscoResponse response = await client.request(url: 'device/save',data: power.toJson());
    return response;
  }

  @override
  Future<ChiscoResponse> deleteDevice(String serialNumber)async {
    ChiscoResponse response = await httpClient.request(url: 'device/delete', data:{'serialNumber':serialNumber});
    return response;
  }
}
