import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/add_schedule_controller.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/widgets/schedule_drop_down.dart';
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

class AddScheduleBottomSheet extends StatelessWidget {
  final bool isPower;
  final Device device;

  const AddScheduleBottomSheet(
      {Key? key, required this.isPower, required this.device})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Connector> connectors = [];

    if (isPower) {
      connectors = (device as Power).connectors;
    }

    AddScheduleController controller = Provider.of<AddScheduleController>(
        context);

    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double scheduleWidth = ChiscoConverter.calculateWidgetWidth(width, 100);
    double scheduleHeight = ChiscoConverter.calculateWidgetWidth(width, 39);
    ScheduleType scheduleType = controller.selectedType;
    bool both = controller.isScheduleItemActive(ScheduleType.both);
    bool on = controller.isScheduleItemActive(ScheduleType.on);
    bool off = controller.isScheduleItemActive(ScheduleType.off);

    if (controller.initState) {
      controller.init();
    }
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
              /*  DropdownButtonHideUnderline(
                        child: DropdownButton2(
                      items: connectors
                          .map((item) => DropdownMenuItem<int>(
                              value: item.connectorId,
                              alignment: Alignment.centerRight,
                              child: ChiscoText(
                                text: item.name,
                              )))
                          .toList(),
                      onChanged: (value) {

                        int index = connectors.indexWhere(
                            (element) => element.connectorId == value);

                        controller.changeDropDownValue(
                            connectors[index].name, value as int);
                      },
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      buttonHeight: buttonHeight,
                      buttonDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      buttonWidth: double.infinity,
                      itemHeight:
                          ChiscoConverter.calculateWidgetHeight(width, 64),
                          itemPadding: const EdgeInsets.only(left: 14, right: 14,top: 5,bottom: 5),
                      hint: Padding(
                        padding: EdgeInsets.only(
                            right: ChiscoConverter.calculateWidgetHeight(
                                width, 20)),
                        child: Row(
                          children: [
                            SvgPicture.asset(DEVICE),
                            const SizedBox(
                              width: 10,
                            ),
                            const ChiscoText(
                              fontWeight: FontWeight.w400,
                              text: 'اسم پورت یا پریز:',
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            ChiscoText(
                              text: controller.dropDownString,
                              fontWeight: FontWeight.w400,
                            )
                          ],
                        ),
                      ),
                      icon: Padding(
                        padding: EdgeInsets.only(
                            left: ChiscoConverter.calculateWidgetHeight(
                                width, 20)),
                        child: SvgPicture.asset(ARROW_BOTTOM),
                      ),

                    )),*/
              ChiscoDropDown(connectors: connectors,
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
                    initialTime: TimeOfDay.now(),
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
                  initialTime: TimeOfDay(
                      hour: TimeOfDay
                          .now()
                          .hour + 1,
                      minute: TimeOfDay
                          .now()
                          .minute),
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
                  isActive: controller.isSelectedScheduleItem(ScheduleDays.sat),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.sat);
                  }),
              AddScheduleItem(
                  scheduleWidth:
                  ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                  ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'ی',
                  isActive: controller.isSelectedScheduleItem(ScheduleDays.sun),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.sun);
                  }),
              AddScheduleItem(
                  scheduleWidth:
                  ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                  ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'د',
                  isActive: controller.isSelectedScheduleItem(ScheduleDays.mon),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.mon);
                  }),
              AddScheduleItem(
                  scheduleWidth:
                  ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                  ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'س',
                  isActive: controller.isSelectedScheduleItem(ScheduleDays.tue),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.tue);
                  }),
              AddScheduleItem(
                  scheduleWidth:
                  ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                  ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'چ',
                  isActive: controller.isSelectedScheduleItem(ScheduleDays.wed),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.wed);
                  }),
              AddScheduleItem(
                scheduleWidth: ChiscoConverter.calculateWidgetWidth(width, 40),
                scheduleHeight: ChiscoConverter.calculateWidgetWidth(width, 40),
                title: 'پ',
                isActive: controller.isSelectedScheduleItem(ScheduleDays.thr),
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
                  isActive: controller.isSelectedScheduleItem(ScheduleDays.fri),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.fri);
                  })
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ChiscoButton(
            text: 'تایید و ثبت زمانبندی',
            onClick: () {
              if (!isPower) {
                controller.addCoolerScheduleBtnClicked(device.serialNumber);
              } else {
                controller.addPowerScheduleBtnClicked(device.serialNumber);
              }
            },
            icon: '',
            hasIcon: false,
          ),
        ],
      ),
    );
  }
}
