import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_source/device/device_data_source.dart';
import 'package:chisco/http_client/httpService.dart';

class DeviceRemoteDataSource extends DeviceDataSource {
  final ChiscoClient client = ChiscoClient();

  @override
  Future<ChiscoResponse> addCooler(AddCooler cooler) async {
    ChiscoResponse chiscoResponse =
        await client.post(url: 'device/save', data: cooler.toJson());
    print(chiscoResponse);
    return chiscoResponse;
  }

  @override
  Future<ChiscoResponse> addPower(AddPower power) async{
  ChiscoResponse response = await client.post(url: 'device/save', data: power.toJson());
  print(response);
  return response;
  }

  @override
  Future<ChiscoResponse> deleteCooler() {
    // TODO: implement deleteCooler
    throw UnimplementedError();
  }

  @override
  Future<ChiscoResponse> deletePower() {
    // TODO: implement deletePower
    throw UnimplementedError();
  }

  @override
  Future<ChiscoResponse> editCooler() {
    // TODO: implement editCooler
    throw UnimplementedError();
  }

  @override
  Future<ChiscoResponse> editPower() {
    // TODO: implement editPower
    throw UnimplementedError();
  }
}
