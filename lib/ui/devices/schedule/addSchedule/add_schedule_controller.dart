import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddSchedule.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/repository/schedule/schedule_repository.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/widgets/add_schedule_item.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

enum ScheduleType { on, off, both }

enum ScheduleDays { sat, sun, mon, tue, wed, thr, fri }

class AddScheduleController extends ChangeNotifier {
  final BuildContext context;
  TextEditingController onTimeController = TextEditingController();
  TextEditingController offTimeController = TextEditingController();

  AddScheduleController(this.context);

  bool onHint = true;
  bool offHint = true;
  ScheduleType selectedType = ScheduleType.on;
  List<String> days = [];

  ScheduleRepositoryImpl repositoryImpl = ScheduleRepositoryImpl();
  String dropDownString = '';
  bool initState = true;

  init() {
    initState = false;

    TimeOfDay oneHourLater = TimeOfDay(
        hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
    offTimeController.text = "${oneHourLater.to24hours()}";

    onTimeController.text = "${TimeOfDay.now().to24hours()}";
  }

  changeOnText(String onTime) {
    onTimeController.text = onTime;

    onHint = false;
    notifyListeners();
  }

  changeOffText(String offText) {
    offTimeController.text = offText;
    offHint = false;
    notifyListeners();
  }

  changeDropDownValue(String value) {
    dropDownString = value;
    print("selecte Drop Down : $value");
    notifyListeners();
  }

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
      days.add(day.name.toString());
    }
    print(days.toString());
    notifyListeners();
  }

  bool isSelectedScheduleItem(ScheduleDays day) {
    return days.contains(day.name);
  }

  addCoolerScheduleBtnClicked(String serialNumber) async {
    ChiscoResponse response = await repositoryImpl.saveSchedule(AddSchedule(
        endTime: offTimeController.text,
        repeat: days,
        serialNumber: serialNumber,
        startTime: onTimeController.text));
    //getNewList show them
    if (response.status) {
      AddDeviceResponse deviceResponse = response.object;

      Provider.of<AppController>(context, listen: false).refreshData(deviceResponse);

      notifyListeners();
      Navigator.pop(context);

    } else {
      print(response.errorMessage);
      print('status 4111 ');
    }
  }
  addPowerScheduleBtnClicked(){

  }
}
