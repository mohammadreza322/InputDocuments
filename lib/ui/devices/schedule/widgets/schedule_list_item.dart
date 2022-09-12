import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/Schedule.dart';
import 'package:chisco/ui/devices/schedule/schedule_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem({Key? key, required this.schedule, required this.index, required this.isPower, this.connectors = const [], required this.device}) : super(key: key);

  final Schedule schedule ;
  final int index;
  final bool isPower;
  final Device device;
  final List<Connector> connectors;
  @override
  Widget build(BuildContext context) {
    ScheduleController controller = Provider.of<ScheduleController>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    int connectorIndex = isPower ? connectors.indexWhere((Connector element) {
    return  element.connectorId == schedule.port;
    }) : 0 ;

    return Container(
      width: ChiscoConverter.calculateWidgetWidth(width, 320),
      height: ChiscoConverter.calculateWidgetWidth(width, 160),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.fromLTRB(
          ChiscoConverter.calculateWidgetWidth(width, 20),
          ChiscoConverter.calculateWidgetWidth(width, 10),
          ChiscoConverter.calculateWidgetWidth(width, 20),
          ChiscoConverter.calculateWidgetWidth(width, 10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [Styles.getBoxShadow(0.07)],
      ),
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Row(
              children: [

                ChiscoText(
                  text: !isPower ? "زماندبندی ${index+1}" : connectors[connectorIndex].name,
                  fontWeight: FontWeight.w400,
                ),
                Expanded(child: Container()),

                ChiscoText(
                  textColor: Styles.primaryColor,
                  text: controller.convertDays(schedule.repeat),
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
                //Ask Amir For Switch
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Switch(
                      //activeColor: Styles.primaryColor,
                      inactiveThumbColor: Colors.white,
                      activeThumbImage: const AssetImage(ACTIVE_SWITCH_THUMB),
                      inactiveThumbImage: const AssetImage(OFF_SWITCH_THUMB),
                      activeTrackColor: const Color(0xff34A6F6),
                      inactiveTrackColor: const Color(0xffE2E3E4),
                      key: UniqueKey(),
                      value: schedule.enable,
                      onChanged: (bool) {

                        controller.enableChanged(bool,schedule,device);

                      }),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Row(
              children: List.generate(20, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Container(
                      height: 1,
                      width: 10,
                      color: const Color(0XFFC4C4C4).withOpacity(0.60),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ChiscoText(
                    text: 'ساعت روشن شدن',
                    fontSize: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(CLOCK),
                      const SizedBox(
                        width: 5,
                      ),
                       ChiscoText(
                         text: schedule.start==''?'-:-':schedule.start.toString(),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  )
                ],
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                      height:
                          ChiscoConverter.calculateWidgetWidth(width, 10)),
                  SvgPicture.asset(
                    SCHEDULE_ARROW,

                    color: const Color(0xffC4C4C4).withOpacity(0.6),
                  ),
                ],
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ChiscoText(
                    text: 'ساعت خاموش شدن',
                    fontSize: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(CLOCK),
                      const SizedBox(
                        width: 5,
                      ),
                       ChiscoText(
                        text: schedule.end==''?'-:-':schedule.end.toString(),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
