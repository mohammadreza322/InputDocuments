import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddSchedule.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/Schedule.dart';
import 'package:chisco/data/repository/schedule/schedule_repository.dart';
import 'package:chisco/ui/devices/cooler/widgets/schedule_btn.dart';
import 'package:chisco/ui/devices/schedule/editSchedule/edit_schedule_bottom_sheet.dart';
import 'package:chisco/ui/devices/schedule/editSchedule/edit_schedule_controller.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/show_chisco_bottom_sheet.dart';
import 'addSchedule/add_schedule.dart';
import 'addSchedule/add_schedule_controller.dart';

class ScheduleController extends ChangeNotifier {
  BuildContext context;

  ScheduleController(this.context);
  bool isEnable = true;
  ScheduleRepositoryImpl repositoryImpl = ScheduleRepositoryImpl();

  onAddScheduleClick(Device device, bool isPower) {
    showChiscoBottomSheet(
        context,
        ChangeNotifierProvider(
          create: (context) => AddScheduleController(context),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: AddScheduleBottomSheet(device: device, isPower: isPower),
          ),
        ));
    // print("is Power  : $isPower");
    notifyListeners();
  }

  String convertDays(List<String> engDays) {
    List<String> farsiList = [];
    for (int i = 0; i < engDays.length; i++) {
      switch (engDays[i]) {
        case 'sat':
          farsiList.add('ش');
          break;
        case 'sun':
          farsiList.add('ی');

          break;
        case 'mon':
          farsiList.add('د');

          break;
        case 'tue':
          farsiList.add('س');

          break;
        case 'wed':
          farsiList.add('چ');
          break;
        case 'thr':
          farsiList.add('پ');
          break;

        case 'fri':
          farsiList.add('ج');
          break;
      }
    }

    return farsiList.join('  ');
  }

  enableChanged(bool values, Schedule schedule, Device device) {
    if (device.deviceType == DeviceType.cooler) {
      // print('^^^^^^^^^^^^^^^^^^^^^^^^');

      // print('Schedule Start : ${schedule.start}');
      // print('Schedule END : ${schedule.end}');
      editCoolerSchedule(device.serialNumber, schedule, values);
    } else
      editPowerSchedule(device.serialNumber, schedule, values);
    notifyListeners();
  }

  editCoolerSchedule(
      String serialNumber, Schedule schedule, bool enable) async {
    ChiscoResponse response = await repositoryImpl.saveSchedule(AddSchedule(
        endTime: schedule.end,
        repeat: schedule.repeat,
        serialNumber: serialNumber,
        id: schedule.id,
        enable: enable,
        startTime: schedule.start));

    // print(response);

    if (response.status) {
      AddDeviceResponse deviceResponse = response.object;

      Provider.of<AppController>(context, listen: false)
          .refreshData(deviceResponse);

      notifyListeners();
      ChiscoFlushBar.showSuccessFlushBar(context, deviceResponse.message);
    } else {
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage!);
      // print(response.errorMessage);
      // print('status 4111 ');
    }
  }

  editPowerSchedule(String serialNumber, Schedule schedule, bool enable) async {
    // print("response");
    ChiscoResponse response = await repositoryImpl.saveSchedule(AddSchedule(
        endTime: schedule.end,
        repeat: schedule.repeat,
        portNumber: schedule.port,
        id: schedule.id,
        enable: enable,
        serialNumber: serialNumber,
        startTime: schedule.start));

    // print(response);
    if (response.status) {
      print(response.status);
      AddDeviceResponse deviceResponse = response.object;
      Provider.of<AppController>(context, listen: false)
          .refreshData(deviceResponse);
      notifyListeners();
      ChiscoFlushBar.showSuccessFlushBar(context, deviceResponse.message);
    } else {
      // ChiscoFlushBar.showFlushBar(context, response.errorMessage!);
      ChiscoFlushBar.showErrorFlushBar(context, 'اسم پورت را تغییر دهید');
      print(response.errorMessage);
      print('status 4111 ');
    }
  }

  onListItemClicked(Device device, bool isPower, Schedule schedule) {
    print(schedule);
    showChiscoBottomSheet(
        context,
        ChangeNotifierProvider(
          create: (context) => EditScheduleController(context),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: EditScheduleBottomSheet(
              device: device,
              schedule: schedule,
            ),
          ),
        ));
    notifyListeners();
  }
}
