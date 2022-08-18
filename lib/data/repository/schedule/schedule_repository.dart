import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddSchedule.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_source/schdule/schedule_remote_data_source.dart';

abstract class ScheduleRepository {
  Future<ChiscoResponse> saveSchedule(AddSchedule schedule);

  Future<ChiscoResponse> editSchedule();
}

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleRemoteDataSource _remoteDataSource = ScheduleRemoteDataSource();

  @override
  Future<ChiscoResponse> editSchedule() {
    // TODO: implement editSchedule
    throw UnimplementedError();
  }

  @override
  Future<ChiscoResponse> saveSchedule(AddSchedule schedule) async {
    ChiscoResponse response = await _remoteDataSource.saveSchedule(schedule);

    if (response.status) {
      AddDeviceResponse addDeviceResponse = AddDeviceResponse.fromJson(response.object);
      ChiscoResponse result = ChiscoResponse(status: response.status, code:response.code,object: addDeviceResponse);
      return result;
    }
    else {
      return response;
    }
  }
}
