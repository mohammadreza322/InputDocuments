import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/data/data_class/Schedule.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/add_schedule_controller.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/widgets/schedule_drop_down.dart';
import 'package:chisco/ui/devices/schedule/editSchedule/edit_schedule_controller.dart';
import 'package:chisco/ui/devices/schedule/editSchedule/time_converter.dart';
import 'package:chisco/ui/devices/schedule/schedule_controller.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/widgets/add_schedule_item.dart';
import 'package:chisco/ui/widget/chisco_time_text_view.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:chisco/utils/converter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

class EditScheduleBottomSheet extends StatelessWidget {
  final Schedule schedule;
  final Device device;

  const EditScheduleBottomSheet(
      {super.key, required this.schedule, required this.device});

  @override
  Widget build(BuildContext context) {
    EditScheduleController controller =
        Provider.of<EditScheduleController>(context);

    double width = MediaQuery.of(context).size.width;
    double scheduleWidth = ChiscoConverter.calculateWidgetWidth(width, 100);
    double scheduleHeight = ChiscoConverter.calculateWidgetWidth(width, 39);

    List<Connector> connectors = [];
    bool isPower = device.deviceType == DeviceType.power;
    if (isPower) {
      connectors = (device as Power).connectors;
      connectors.forEach((element) {
        if(element.name==""){
          if(element.connectorType=='usb'){
           //print('Edit Callled');
            element.name = 'پورت ${element.connectorId-4}';
          }else{
            element.name = 'پریز ${element.connectorId}';
          }

        }
      });
    }

    if (controller.initState) {
      controller.init();
      controller.days = schedule.repeat
          .map((e) =>
              ScheduleDays.values.firstWhere((element) => element.name == e))
          .toList();
      controller.onTime = schedule.start;
      controller.offTime = schedule.end;

      if (schedule.start != '' && schedule.end != '') {
        print('BOTH');
        controller.changeSelectedScheduleItem(ScheduleType.both);
      } else if (schedule.start != '' && schedule.end == '') {
        print('START');

        controller.changeSelectedScheduleItem(ScheduleType.on);
      } else {
        print('END');

        controller.changeSelectedScheduleItem(ScheduleType.off);

      }

      if (isPower) {
        print(connectors[schedule.port!-1].name);
        controller.dropDownString = connectors[schedule.port! - 1].name;
        controller.connectorId = schedule.port!;
      }
    }
    bool both = controller.isScheduleItemActive(ScheduleType.both);
    bool on = controller.isScheduleItemActive(ScheduleType.on);
    bool off = controller.isScheduleItemActive(ScheduleType.off);


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListHandlerView(),
          const SizedBox(
            height: 15,
          ),
          const ChiscoText(
            text: 'ثبت زمانبندی جدید',
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddScheduleItem(
                title: 'روشن شدن',
                scheduleWidth: scheduleWidth,
                scheduleHeight: scheduleHeight,
                isActive: controller.isScheduleItemActive(ScheduleType.on),
                onClick: () {
                  controller.changeSelectedScheduleItem(ScheduleType.on);
                },
              ),
              AddScheduleItem(
                  title: 'خاموش شدن',
                  scheduleWidth: scheduleWidth,
                  scheduleHeight: scheduleHeight,
                  isActive: controller.isScheduleItemActive(ScheduleType.off),
                  onClick: () {
                    controller.changeSelectedScheduleItem(ScheduleType.off);
                  }),
              AddScheduleItem(
                  title: 'هر دو',
                  scheduleWidth: scheduleWidth,
                  scheduleHeight: scheduleHeight,
                  isActive: controller.isScheduleItemActive(ScheduleType.both),
                  onClick: () {
                    controller.changeSelectedScheduleItem(ScheduleType.both);
                  }),
            ],
          ),
          isPower
              ? const SizedBox(
                  height: 10,
                )
              : const SizedBox(
                  height: 20,
                ),
          isPower
              ? Column(
                  children: [
                    ChiscoDropDown(
                        connectors: connectors,
                        onDropDownChange: (value) {

                          int index = connectors.indexWhere(
                                  (element) => element.connectorId == value);

                          controller.changeDropDownValue(
                              connectors[index].name, value as int);

                        },
                        dropDownString: controller.dropDownString),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : Container(),
          on || both
              ? ChiscoTimeSelector(
                  icon: CLOCK,
                  label: 'ساعت روشن شدن',
                  isHint: controller.onHint,
                  text: controller.onTimeController.text,
                  onClick: () async {
                    var picked = await showPersianTimePicker(
                        context: context,
                        initialTime: controller.onTime == ''
                            ? TimeOfDay.now()
                            : TimeOfDay(
                                hour: TimeConverter.getHour(controller.onTime),
                                minute:
                                    TimeConverter.getMin(controller.onTime)),
                        buttonTextStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                        titleTextStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        initialEntryMode: PTimePickerEntryMode.dial);
                    if (picked != null) {
                      controller.changeOnTimeText(picked.to24hours());
                    }
                  })
              : Container(),
          both
              ? const SizedBox(
                  height: 10,
                )
              : Container(),
          off || both
              ? ChiscoTimeSelector(
                  icon: CLOCK,
                  label: 'ساعت خاموش شدن',
                  text: controller.offTimeController.text,
                  isHint: controller.offHint,
                  onClick: () async {
                    var picked = await showPersianTimePicker(
                      context: context,
                      initialTime: controller.offTime == ''
                          ? TimeOfDay.now()
                          : TimeOfDay(
                              hour: TimeConverter.getHour(controller.offTime),
                              minute: TimeConverter.getMin(controller.offTime)),
                      buttonTextStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      titleTextStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    );
                    if (picked != null) {
                      controller.changeOffTimeText(picked.to24hours());
                    }
                  })
              : Container(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddScheduleItem(
                  scheduleWidth:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'ش',
                  isActive:
                      controller.isSelectedScheduleDayActive(ScheduleDays.sat),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.sat);
                  }),
              AddScheduleItem(
                  scheduleWidth:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'ی',
                  isActive:
                      controller.isSelectedScheduleDayActive(ScheduleDays.sun),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.sun);
                  }),
              AddScheduleItem(
                  scheduleWidth:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'د',
                  isActive:
                      controller.isSelectedScheduleDayActive(ScheduleDays.mon),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.mon);
                  }),
              AddScheduleItem(
                  scheduleWidth:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'س',
                  isActive:
                      controller.isSelectedScheduleDayActive(ScheduleDays.tue),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.tue);
                  }),
              AddScheduleItem(
                  scheduleWidth:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'چ',
                  isActive:
                      controller.isSelectedScheduleDayActive(ScheduleDays.wed),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.wed);
                  }),
              AddScheduleItem(
                scheduleWidth: ChiscoConverter.calculateWidgetWidth(width, 40),
                scheduleHeight: ChiscoConverter.calculateWidgetWidth(width, 40),
                title: 'پ',
                isActive:
                    controller.isSelectedScheduleDayActive(ScheduleDays.thr),
                onClick: () {
                  controller.changeSelectedDayItem(ScheduleDays.thr);
                },
              ),
              AddScheduleItem(
                  scheduleWidth:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'ج',
                  isActive:
                      controller.isSelectedScheduleDayActive(ScheduleDays.fri),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.fri);
                  })
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    print("delete clicked");
                    controller.onScheduleDeleteBtnClicked(
                        device.serialNumber, schedule.id);
                  },
                  child: Container(
                    height: ChiscoConverter.calculateWidgetWidth(
                        width, buttonHeight),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [Styles.getBoxShadow(0.07)],
                        gradient: const LinearGradient(
                            colors: [Color(0xffD92249), Color(0xffCC2045)])),
                    child: Center(child: SvgPicture.asset(TRASH)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: ChiscoButton(
                  text: 'تایید و ثبت زمانبندی',
                  onClick: () {
                    if (!isPower) {
                      controller.editCoolerScheduleBtnClicked(
                          device.serialNumber, schedule.id);
                    } else {
                      controller.editPowerScheduleBtnClicked(
                          device.serialNumber, schedule.id);
                    }

                  },
                  icon: '',
                  hasIcon: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
