import 'package:chisco/data/data_class/AddSchedule.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';

abstract class ScheduleDataSource {
  Future<ChiscoResponse> saveSchedule(AddSchedule schedule);


  Future<ChiscoResponse> editSchedule();
}
