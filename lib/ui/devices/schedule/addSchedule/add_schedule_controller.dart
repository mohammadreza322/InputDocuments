import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddSchedule.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/repository/schedule/schedule_repository.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/widgets/add_schedule_item.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

enum ScheduleType { on, off, both }

enum ScheduleDays { sat, sun, mon, tue, wed, thr, fri }

class AddScheduleController extends ChangeNotifier {
  final BuildContext context;

  AddScheduleController(this.context);

  TextEditingController onTimeController = TextEditingController();
  TextEditingController offTimeController = TextEditingController();

  ScheduleRepositoryImpl repositoryImpl = ScheduleRepositoryImpl();

  bool onHint = true;
  bool offHint = true;
  ScheduleType selectedType = ScheduleType.on;

  List<ScheduleDays> days = [];
  String dropDownString = '';
  int connectorId = 0;
  bool initState = true;

  init() {
    initState = false;
    TimeOfDay oneHourLater = TimeOfDay(
        hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
    if (selectedType == ScheduleType.both) {
      onTimeController.text = TimeOfDay.now().to24hours();
      offTimeController.text = oneHourLater.to24hours();
      print("Both");
    } else if (selectedType == ScheduleType.off) {
      offTimeController.text = oneHourLater.to24hours();
      print("off");
    } else {
      onTimeController.text = TimeOfDay.now().to24hours();
      print("Onn");
    }
  }

  changeOnTimeText(String onTime) {
    onTimeController.text = onTime;
    onHint = false;
    notifyListeners();
  }

  changeOffTimeText(String offText) {
    offTimeController.text = offText;
    offHint = false;
    notifyListeners();
  }

  changeDropDownValue(String value, int id) {
    dropDownString = value;
    connectorId = id;
    print("select Drop Down : $value");
    notifyListeners();
  }

  changeSelectedScheduleItem(ScheduleType type) {
    selectedType = type;
    TimeOfDay oneHourLater = TimeOfDay(
        hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
    if (selectedType == ScheduleType.both) {
      onTimeController.text = TimeOfDay.now().to24hours();
      offTimeController.text = oneHourLater.to24hours();
      print("Both");
    }
    if (selectedType == ScheduleType.on) {
      onTimeController.text = TimeOfDay.now().to24hours();
      print("On");
    } else if (selectedType == ScheduleType.off) {
      offTimeController.text = oneHourLater.to24hours();
      print("Off");
    }

    notifyListeners();
  }

  bool isScheduleItemActive(ScheduleType type) {
    // print("Schedule Type : $type");
    return selectedType == type;
  }

  changeSelectedDayItem(ScheduleDays day) {
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }

    days.sort((a, b) {
      if (a.index < b.index) {
        return -1;
      } else if (a.index > b.index) {
        return 1;
      }
      return 0;
    });

    notifyListeners();
  }

  bool isSelectedScheduleItem(ScheduleDays day) {
    return days.contains(day);
  }

  addCoolerScheduleBtnClicked(String serialNumber) async {
    ChiscoResponse? response;
    switch(selectedType){
      case ScheduleType.both:{
        if(onHint || offHint){
          ChiscoFlushBar.showErrorFlushBar(
              context, 'ساعت روشن و خاموش شدن هردو باید وارد شود.');
          return;
        }else {
          response = await repositoryImpl.saveSchedule(AddSchedule(
              endTime: selectedType != ScheduleType.on
                  ? !offHint
                  ? offTimeController.text
                  : null
                  : null,
              repeat: days.map((e) => e.name).toList(),
              serialNumber: serialNumber,
              startTime: selectedType != ScheduleType.off
                  ? !onHint
                  ? onTimeController.text
                  : null
                  : null));
        }
      break;
      }
      case ScheduleType.on:{
        if(onHint){
          ChiscoFlushBar.showErrorFlushBar(
              context, 'ساعت روشن شدن باید وارد شود.');
          return;
        }else {
          response = await repositoryImpl.saveSchedule(AddSchedule(
              endTime: selectedType != ScheduleType.on
                  ? !offHint
                  ? offTimeController.text
                  : null
                  : null,
              repeat: days.map((e) => e.name).toList(),
              serialNumber: serialNumber,
              startTime: selectedType != ScheduleType.off
                  ? !onHint
                  ? onTimeController.text
                  : null
                  : null));
        }
        break;
      }

      case ScheduleType.off:{
        if(offHint){
          ChiscoFlushBar.showErrorFlushBar(
              context, 'ساعت خاموش شدن باید وارد شود.');
          return;

        }else {
          response = await repositoryImpl.saveSchedule(AddSchedule(
              endTime: selectedType != ScheduleType.on
                  ? !offHint
                  ? offTimeController.text
                  : null
                  : null,
              repeat: days.map((e) => e.name).toList(),
              serialNumber: serialNumber,
              startTime: selectedType != ScheduleType.off
                  ? !onHint
                  ? onTimeController.text
                  : null
                  : null));
        }
        break;
      }
    }


    if (response.status) {
      AddDeviceResponse deviceResponse = response.object;
      Provider.of<AppController>(context, listen: false)
          .refreshData(deviceResponse);
      notifyListeners();
      Navigator.pop(context);
      ChiscoFlushBar.showSuccessFlushBar(context, deviceResponse.message);
    } else {
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
      print(response.errorMessage);
      print('status 4111 ');
    }

  }

  addPowerScheduleBtnClicked(String serialNumber) async {
    ChiscoResponse? response;
    switch(selectedType){
      case ScheduleType.both:{
        if(onHint || offHint){
          ChiscoFlushBar.showErrorFlushBar(
              context, 'ساعت روشن و خاموش شدن هردو باید وارد شود.');
          return;
        }else {
          response = await repositoryImpl.saveSchedule(AddSchedule(
              endTime: selectedType != ScheduleType.on
                  ? !offHint
                  ? offTimeController.text
                  : null
                  : null,
              repeat: days.map((e) => e.name).toList(),
              portNumber: connectorId,
              serialNumber: serialNumber,
              startTime: selectedType != ScheduleType.off
                  ? !onHint
                  ? onTimeController.text
                  : null
                  : null));
        }
        break;
      }
      case ScheduleType.on:{
        if(onHint){
          ChiscoFlushBar.showErrorFlushBar(
              context, 'ساعت روشن شدن باید وارد شود.');
          return;
        }else {
          response = await repositoryImpl.saveSchedule(AddSchedule(
              endTime: selectedType != ScheduleType.on
                  ? !offHint
                  ? offTimeController.text
                  : null
                  : null,
              repeat: days.map((e) => e.name).toList(),
              serialNumber: serialNumber,
              portNumber: connectorId,

              startTime: selectedType != ScheduleType.off
                  ? !onHint
                  ? onTimeController.text
                  : null
                  : null));
        }
        break;
      }

      case ScheduleType.off:{
        if(offHint){
          ChiscoFlushBar.showErrorFlushBar(
              context, 'ساعت خاموش شدن باید وارد شود.');
          return;

        }else {
          response = await repositoryImpl.saveSchedule(AddSchedule(
              endTime: selectedType != ScheduleType.on
                  ? !offHint
                  ? offTimeController.text
                  : null
                  : null,
              repeat: days.map((e) => e.name).toList(),
              serialNumber: serialNumber,
              portNumber: connectorId,

              startTime: selectedType != ScheduleType.off
                  ? !onHint
                  ? onTimeController.text
                  : null
                  : null));
        }
        break;
      }
    }

    if (response.status) {
      AddDeviceResponse deviceResponse = response.object;
      Provider.of<AppController>(context, listen: false)
          .refreshData(deviceResponse);
      notifyListeners();
      Navigator.pop(context);
      ChiscoFlushBar.showSuccessFlushBar(context, deviceResponse.message);
    } else {
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
      print(response.errorMessage);
      print('status 4111 ');
    }

   /* ChiscoResponse response = await repositoryImpl.saveSchedule(AddSchedule(
        endTime: selectedType != ScheduleType.on ? offTimeController.text : null,
        repeat: days.map((e) => e.name).toList(),
        portNumber: connectorId,
        serialNumber: serialNumber,
        startTime:
            selectedType != ScheduleType.off ? onTimeController.text : null));
    if (response.status) {
      AddDeviceResponse deviceResponse = response.object;

      Provider.of<AppController>(context, listen: false).refreshData(deviceResponse);

      notifyListeners();
      Navigator.pop(context);

      ChiscoFlushBar.showSuccessFlushBar(context, deviceResponse.message);

    } else {
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
      print(response.errorMessage);
      print('status 4111 ');
    }*/
  }
}
