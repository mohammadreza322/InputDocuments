import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/data/data_source/device/device_remote_data_source.dart';
import 'package:chisco/data/repository/device/device_repository.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  final DeviceRemoteDataSource dataSource = DeviceRemoteDataSource();

  @override
  Future<ChiscoResponse> addCooler(AddCooler cooler) async {
    ChiscoResponse response = await dataSource.addCooler(cooler);
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
    ChiscoResponse response = await dataSource.addPower(power);

    if (response.status) {
      ChiscoResponse result = ChiscoResponse(
          status: response.status,
          code: response.code,
          object: AddDeviceResponse.fromJson(response.object));
      return result;
    }
    return response;
  }
}
