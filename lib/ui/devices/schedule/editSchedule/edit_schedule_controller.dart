
import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddSchedule.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/Schedule.dart';
import 'package:chisco/data/repository/schedule/schedule_repository.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/add_schedule_controller.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScheduleController extends ChangeNotifier{
  final BuildContext context;
  EditScheduleController(this.context);

  TextEditingController onTimeController = TextEditingController();
  TextEditingController offTimeController = TextEditingController();

  ScheduleRepositoryImpl repositoryImpl = ScheduleRepositoryImpl();
  bool onHint = false;
  bool offHint = false;
  ScheduleType selectedType = ScheduleType.on;
  List<ScheduleDays> days = [];
  String dropDownString = '';
  int connectorId = 0;
  bool initState = true;

  String onTime = '00:00';
  String offTime = '00:00';



  init(){
    initState = false;
    TimeOfDay oneHourLater = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
    /*if (selectedType == ScheduleType.on) {
      onTimeController.text = 13.toString();
    } else if (selectedType == ScheduleType.off) {
      offTimeController.text = oneHourLater.to24hours();
    } else {
      onTimeController.text = TimeOfDay.now().to24hours();
      offTimeController.text = oneHourLater.to24hours();
    }*/
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

  changeSelectedScheduleItem(ScheduleType type) async {
    selectedType = type;
    TimeOfDay oneHourLater = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);

    if (selectedType == ScheduleType.on) {
      onTimeController.text =onTime==''?'-:-':onTime;
    } else if (selectedType == ScheduleType.off) {
      offTimeController.text = offTime!=''?offTime:'-:-';
    } else {
      onTimeController.text =  onTime==''?'-:-':onTime;
      offTimeController.text =offTime!=''?offTime:'-:-';
    }

    await Future.delayed(Duration(milliseconds: 250));

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
    print(days.toString());

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

  bool isSelectedScheduleDayActive(ScheduleDays day) {
    print("Days List : $days");
    return days.contains(day);
  }




  editCoolerScheduleBtnClicked(String serialNumber,String id) async {
    ChiscoResponse response = await repositoryImpl.saveSchedule(AddSchedule(
        endTime: selectedType != ScheduleType.on ? offTimeController.text : null,
        repeat: days.map((e) => e.name).toList(),

        serialNumber: serialNumber,
        id: id,
        startTime: selectedType != ScheduleType.off ? onTimeController.text : null));
    print(response);

    if (response.status) {
      AddDeviceResponse deviceResponse = response.object;

      Provider.of<AppController>(context, listen: false).refreshData(deviceResponse);

      notifyListeners();
      Navigator.pop(context);
      ChiscoFlushBar.showSuccessFlushBar(context,deviceResponse.message);


    } else {

      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage!);
      print(response.errorMessage);
      print('status 4111 ');
    }
  }

  editPowerScheduleBtnClicked(String serialNumber,String id) async {
    print("response");
    print( days.map((e) => e.name).toList());
    ChiscoResponse response = await repositoryImpl.saveSchedule(AddSchedule(
        endTime: selectedType != ScheduleType.on ? offTimeController.text : null,
        repeat: days.map((e) => e.name).toList(),
        portNumber: connectorId,
        id: id,
        serialNumber: serialNumber,
        startTime: selectedType != ScheduleType.off ? onTimeController.text : null));

    print(response);
    if (response.status) {
      print(response.status);
      AddDeviceResponse deviceResponse = response.object;
      Provider.of<AppController>(context, listen: false).refreshData(deviceResponse);
      notifyListeners();
      Navigator.pop(context);
      ChiscoFlushBar.showSuccessFlushBar(context,deviceResponse.message);

    } else {
      // ChiscoFlushBar.showFlushBar(context, response.errorMessage!);
      ChiscoFlushBar.showErrorFlushBar(context, 'اسم پورت را تغییر دهید');
      print(response.errorMessage);
      print('status 4111 ');
    }
  }

  onScheduleDeleteBtnClicked(String serialNumber, String id) async {
    ChiscoResponse response =
    await repositoryImpl.deleteSchedule(serialNumber, id);
    AddDeviceResponse addDeviceResponse =response.object;
    if (response.status) {
      Provider.of<AppController>(context, listen: false)
          .refreshData(addDeviceResponse);
      notifyListeners();
      Navigator.pop(context);
      ChiscoFlushBar.showSuccessFlushBar(context,addDeviceResponse.message );
    } else {
      ChiscoFlushBar.showErrorFlushBar(context,response.errorMessage);
      print('status 4111 ');
    }
  }
}