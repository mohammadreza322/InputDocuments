import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/EditCoolerRequest.dart';
import 'package:chisco/data/data_class/EditPowerRequest.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/data/data_source/device/device_remote_data_source.dart';
import 'package:chisco/data/repository/device/device_repository.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  final DeviceRemoteDataSource _dataSource = DeviceRemoteDataSource();

  @override
  Future<ChiscoResponse> addCooler(AddCooler cooler) async {
    ChiscoResponse response = await _dataSource.addCooler(cooler);
    if (response.status) {
      print(response.object.toString());
      ChiscoResponse result = ChiscoResponse(
          status: response.status,
          code: response.code,
          object: AddDeviceResponse.fromJson(response.object));
      return result;
    }
    return response;
  }

  @override
  Future<ChiscoResponse> addPower(AddPower power) async {
    ChiscoResponse response = await _dataSource.addPower(power);

    if (response.status) {
      ChiscoResponse result = ChiscoResponse(
          status: response.status,
          code: response.code,
          object: AddDeviceResponse.fromJson(response.object));
      return result;
    }
    return response;
  }

  @override
  Future<ChiscoResponse> deleteDevice(String serialNumber) async {
    ChiscoResponse response = await _dataSource.deleteDevice(serialNumber);
    if (response.status) {
      ChiscoResponse result = ChiscoResponse(
          status: response.status,
          code: response.code,
          object: AddDeviceResponse.fromJson(response.object));
      return result;
    }

    return response;
  }

  @override
  Future<ChiscoResponse> editCooler(EditCooler cooler) async{
    ChiscoResponse response = await _dataSource.editCooler(cooler);
    if(response.status){
      ChiscoResponse result = ChiscoResponse(status: response.status, code:response.code,object: AddDeviceResponse.fromJson(response.object));
      return result;
    }
    return response;
  }

  @override
  Future<ChiscoResponse> editPower(EditPower power) async {
    ChiscoResponse response = await _dataSource.editPower(power);
    if(response.status){
      ChiscoResponse result = ChiscoResponse(status: response.status, code:response.code,object: AddDeviceResponse.fromJson(response.object));
      return result;
    }
    return response;
  }
}
