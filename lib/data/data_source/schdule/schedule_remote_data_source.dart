import 'package:chisco/data/data_class/AddSchedule.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/http_client/httpService.dart';

abstract class ScheduleDataSource {
  Future<ChiscoResponse> saveSchedule(AddSchedule schedule);

  Future<ChiscoResponse> deleteSchedule(
      String deviceSerialNumber, String scheduleId);
}

class ScheduleRemoteDataSource extends ScheduleDataSource {
  ChiscoClient _client = ChiscoClient();

  @override
  Future<ChiscoResponse> saveSchedule(AddSchedule schedule) async {
    ChiscoResponse response =
        await _client.request(url: 'device/schedule', data: schedule.toJson());
    return response;
  }

  @override
  Future<ChiscoResponse> deleteSchedule(
      String deviceSerialNumber, String scheduleId) async {
    return await _client.request(
        url: 'device/delete-schedule',
        data: {'serialNumber': deviceSerialNumber, 'id': scheduleId});
  }
}
