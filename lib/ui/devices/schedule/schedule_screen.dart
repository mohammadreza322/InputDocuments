import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/add_schedule.dart';
import 'package:chisco/ui/devices/schedule/schedule_controller.dart';
import 'package:chisco/ui/devices/schedule/widgets/schedule_empty_state.dart';
import 'package:chisco/ui/devices/schedule/widgets/schedule_header.dart';
import 'package:chisco/ui/devices/schedule/widgets/schedule_list_item.dart';
import 'package:chisco/ui/devices/widgets/device_appbar.dart';
import 'package:chisco/ui/devices/widgets/device_header.dart';
import 'package:chisco/ui/widget/scroll_behavior.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/empty_state.dart';
import 'package:chisco/ui/widget/show_chisco_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/converter.dart';
import 'addSchedule/add_schedule_controller.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScheduleController controller = Provider.of<ScheduleController>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double iconWidth = (36 / 360) * width;
    final selectedDevice = ModalRoute.of(context)!.settings.arguments as Cooler;

    return SafeArea(
        child: Scaffold(
            backgroundColor: Styles.backGroundColor,
            body: Stack(children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: ChiscoConverter.calculateWidgetHeight(height, 260),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/home_header.png'),
                            fit: BoxFit.cover)),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: DeviceAppBar(
                        title: 'زمان بندی دستگاه',
                        onBackClick: () {Navigator.pop(context);},
                        onMenuClick: () {},
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(
                    top: ChiscoConverter.calculateWidgetHeight(height, 70)),
                padding: EdgeInsets.all(
                    ChiscoConverter.calculateWidgetWidth(width, 20)),
                decoration: const BoxDecoration(
                    color: Styles.backGroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChiscoText(
                            text: selectedDevice.name,
                            fontWeight: FontWeight.w400,
                          ),
                          ChiscoText(
                              text: selectedDevice.category,
                              textColor: Styles.secondaryTextColor,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.onAddScheduleClick(selectedDevice is Power);
                        },
                        child: Container(
                            width: iconWidth,
                            height: iconWidth,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [Styles.getBoxShadow(0.07)]),
                            child: SvgPicture.asset(PLUS_ICON)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: ScrollConfiguration(
                    behavior: ChiscoScrollBehavior(),

                    child: ListView.builder(
                        itemCount: selectedDevice.schedule.length,
                        itemBuilder: (context, index) {
                          return  ScheduleListItem(schedule:selectedDevice.schedule[index]);
                        }),
                  )

                      /* Align(
                        alignment: Alignment.center, child: ScheduleEmptyState()),*/
                      ),
                ]),
              )
            ])));
  }
}
