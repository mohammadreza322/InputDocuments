import 'package:chisco/data/data_class/AddSchedule.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_source/schdule/schedule_data_source.dart';
import 'package:chisco/http_client/httpService.dart';

class ScheduleRemoteDataSource extends ScheduleDataSource {
  ChiscoClient _client = ChiscoClient();

  @override
  Future<ChiscoResponse> editSchedule() {
    // TODO: implement editSchedule
    throw UnimplementedError();
  }

  @override
  Future<ChiscoResponse> saveSchedule(AddSchedule schedule) async {
    ChiscoResponse response = await _client.post(url: 'device/add-schedule',
        data: schedule.toJson());
    return response;
  }

}