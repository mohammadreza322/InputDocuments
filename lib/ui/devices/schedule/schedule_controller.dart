import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/show_chisco_bottom_sheet.dart';
import 'addSchedule/add_schedule.dart';
import 'addSchedule/add_schedule_controller.dart';

class ScheduleController extends ChangeNotifier {
  BuildContext context;

  ScheduleController(this.context);

  onAddScheduleClick(bool isPower) {
    showChiscoBottomSheet(
        context,
        ChangeNotifierProvider(
          create: (context) => AddScheduleController(context),
          child: const Directionality(
            textDirection: TextDirection.rtl,
            child: AddScheduleBottomSheet(isPower: false),
          ),
        ));
    print("is Power  : $isPower");
    notifyListeners();
  }

  String convertDays(List<String> engDays) {
    List<String> farsiList=[];
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
        case 'thu':
          farsiList.add('پ');

          break;
        case 'fri':
          farsiList.add('ج');
          break;
      }

    }

    return farsiList.join(' ');
  }

  void enableChanged(bool values) {}
}
