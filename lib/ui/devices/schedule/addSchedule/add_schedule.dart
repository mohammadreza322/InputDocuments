import 'package:chisco/ui/devices/schedule/addSchedule/add_schedule_controller.dart';
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

  const AddScheduleBottomSheet({Key? key, required this.isPower})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'یو اس بی هدفون 1',
      'یو اس بی هدفون 2',
      'یو اس بی هدفون 3',
      'یو اس بی هدفون 4',
      'یو اس بی هدفون 5',
    ];

    AddScheduleController controller =
        Provider.of<AddScheduleController>(context);

    final TextEditingController onTimeController = TextEditingController();
    final TextEditingController offTimeController = TextEditingController();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double scheduleWidth = ChiscoConverter.calculateWidgetWidth(width, 100);
    double scheduleHeight = ChiscoConverter.calculateWidgetWidth(width, 39);
    ScheduleType scheduleType = controller.selectedType;
    bool both = controller.changeScheduleCompareItems(ScheduleType.both);
    bool on = controller.changeScheduleCompareItems(ScheduleType.on);
    bool off = controller.changeScheduleCompareItems(ScheduleType.off);

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
          /* Flexible(child: ListView.builder(itemBuilder: (context, index) {
          ScheduleItem item = items[index];
          return AddScheduleItem(scheduleWidth: scheduleWidth,
              scheduleHeight: scheduleHeight,
              title: item.title,
              isActive: item.isSelected,
              onClick: (){
            controller.changeScheduleItem(item);
              });
        },)),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddScheduleItem(
                title: 'روشن شدن',
                scheduleWidth: scheduleWidth,
                scheduleHeight: scheduleHeight,
                isActive: controller.changeScheduleCompareItems(ScheduleType.on),
                onClick: () {
                  controller.changeSelectedScheduleItem(ScheduleType.on);
                },
              ),
              AddScheduleItem(
                  title: 'خاموش شدن',
                  scheduleWidth: scheduleWidth,
                  scheduleHeight: scheduleHeight,
                  isActive:
                      controller.changeScheduleCompareItems(ScheduleType.off),
                  onClick: () {
                    controller.changeSelectedScheduleItem(ScheduleType.off);
                  }),
              AddScheduleItem(
                  title: 'هر دو',
                  scheduleWidth: scheduleWidth,
                  scheduleHeight: scheduleHeight,
                  isActive:
                      controller.changeScheduleCompareItems(ScheduleType.both),
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
                    DropdownButtonHideUnderline(
                        child: DropdownButton2(
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              alignment: Alignment.centerRight,
                              child: ChiscoText(
                                text: item,
                              )))
                          .toList(),
                      onChanged: (value) {},
                      buttonHeight: 48,
                      buttonDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      buttonWidth: double.infinity,
                      itemHeight: ChiscoConverter.calculateWidgetHeight(
                          width, buttonHeight),
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
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : Container(),

          /*ChiscoTextField(
            controller: onTimeController,
            hintText: '12:34',
            icon: CLOCK,
            label: "ساعت روشن شدن",
          ),*/
          on || both
              ? ChiscoTimeSelector(
                  icon: CLOCK,
                  label: 'ساعت روشن شدن',
                  text: '15:15',
                  onClick: () async {
                    var picked = await showPersianTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      buttonTextStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      titleTextStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    );

                    var label = picked!.format(context);
                    print(label.toString());
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
                  text: '15:15',
                  onClick: () async {
                    var picked = await showPersianTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      buttonTextStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      titleTextStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                      /*builder: (context,child){
                    return Directionality(textDirection: TextDirection.rtl, child: ChiscoText(text: 'Text -1212',));
                  }*/
                    );

                    var label = picked!.format(context);
                    print(label.toString());
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
                  scheduleWidth:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  scheduleHeight:
                      ChiscoConverter.calculateWidgetWidth(width, 40),
                  title: 'پ',
                  isActive: controller.isSelectedScheduleItem(ScheduleDays.thu),
                  onClick: () {
                    controller.changeSelectedDayItem(ScheduleDays.thu);

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
              //serial => arg

            },
            icon: '',
            hasIcon: false,
          ),
        ],
      ),
    );
  }
}
