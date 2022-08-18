import 'package:chisco/data/data_class/AddSchedule.dart';
import 'package:chisco/data/repository/schedule/schedule_repository.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/widgets/add_schedule_item.dart';
import 'package:flutter/material.dart';

enum ScheduleType { on, off, both }

enum ScheduleDays { sat, sun, mon, tue, wed, thu, fri }

class AddScheduleController extends ChangeNotifier {
  final BuildContext context;

  AddScheduleController(this.context);

  ScheduleType selectedType = ScheduleType.on;
  List<String> days = [];

  ScheduleRepositoryImpl repositoryImpl = ScheduleRepositoryImpl();

  changeSelectedScheduleItem(ScheduleType type) {
    selectedType = type;
    notifyListeners();
  }

  bool changeScheduleCompareItems(ScheduleType type) {
    return selectedType == type;
  }

  changeSelectedDayItem(ScheduleDays day) {
    if (days.contains(day.name)) {
      days.remove(day.name);
    } else {
      days.add(day.name);
    }
    print(days.toString());
    notifyListeners();
  }

  bool isSelectedScheduleItem(ScheduleDays day) {
    return days.contains(day.name);
  }

  addCoolerScheduleBtnClicked (String serialNumber, String? startTime, String? endTime) async{
    await repositoryImpl.saveSchedule(AddSchedule(
        endTime: endTime,
        repeat: days,
        serialNumber: serialNumber,
        startTime: startTime));
    //getNewList show them

    Navigator.pop(context);
  }
}
