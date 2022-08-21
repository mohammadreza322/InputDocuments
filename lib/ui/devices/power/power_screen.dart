import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_btn.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_cooler_bottom_sheet.dart';
import 'package:chisco/ui/devices/cooler/widgets/schedule_btn.dart';
import 'package:chisco/ui/devices/power/widgets/edit_power_bottom_sheet.dart';
import 'package:chisco/ui/devices/power/widgets/power_header.dart';
import 'package:chisco/ui/devices/power/widgets/power_list_item.dart';
import 'package:chisco/ui/devices/schedule/schedule_controller.dart';
import 'package:chisco/ui/devices/widgets/device_appbar.dart';
import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:chisco/ui/widget/scroll_behavior.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/power_icon.dart';
import 'package:chisco/ui/widget/show_chisco_bottom_sheet.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PowerScreen extends StatelessWidget {
  const PowerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final selectedPower = ModalRoute.of(context)!.settings.arguments as Power;

    return SafeArea(
        child: Container(
      height: ChiscoConverter.calculateWidgetHeight(height, 280),
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(APP_HEADER_BACKGROUND_IMAGE),
              alignment: Alignment.topCenter)),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: DeviceAppBar(
                  onMenuClick: () {}, onBackClick: () {Navigator.pop(context);}, title: 'سه راهی'),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * .2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textDirection: TextDirection.ltr,
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: '120',
                                style: TextStyle(
                                    fontFamily: "ChiscoText",
                                    fontSize: 50,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            TextSpan(
                                text: ' w',
                                style: TextStyle(
                                    fontFamily: "ChiscoText",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      const ChiscoText(
                        text: 'ولتاژ لحظه‌ای کل سه راهی',
                        fontWeight: FontWeight.w500,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              DraggableScrollableSheet(
                expand: true,
                minChildSize: 0.75,
                maxChildSize: 0.98,
                initialChildSize: 0.75,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Styles.backGroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              ChiscoConverter.calculateWidgetWidth(width, 0),
                          horizontal:
                              ChiscoConverter.calculateWidgetWidth(width, 20)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: ChiscoConverter.calculateWidgetWidth(
                                    width, 20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ChiscoText(
                                        text: selectedPower.name,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      ChiscoText(
                                        text: selectedPower.category,
                                        fontWeight: FontWeight.w400,
                                        textColor: Styles.secondaryTextColor,
                                      )
                                    ],
                                  ),
                                ),
                                scheduleBtn(
                                  width: 32,
                                  onClick: () {
                                    Navigator.pushNamed(context, schedulePage, arguments: selectedPower);
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                EditCoolerBtn(
                                    width: 32,
                                    onClick: () {
                                      showChiscoBottomSheet(context,
                                          const EditPowerBottomSheet());
                                    }),
                                const SizedBox(
                                  width: 10,
                                ),
                                PowerIcon(
                                  isActive: true,
                                  onClick: () {
                                    //todo Power Btn onClick
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height:
                                ChiscoConverter.calculateWidgetWidth(width, 6),
                          ),
                          Expanded(
                              child: ScrollConfiguration(
                            behavior: ChiscoScrollBehavior(),
                            child: ListView.builder(
                              itemCount: selectedPower.connectors.length,
                              shrinkWrap: false,
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                Connector connector = selectedPower.connectors[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical:
                                        ChiscoConverter.calculateWidgetWidth(
                                            width, 5),
                                  ),
                                  child: PowerListItem(
                                    title: connector.name,
                                    description: connector.connectorType,
                                    isPower: connector.connectorType == 'power',
                                    isActive: connector.status,
                                  ),
                                );
                              },
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          )),
    ));
  }
}
