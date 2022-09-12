import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_btn.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_cooler_bottom_sheet.dart';
import 'package:chisco/ui/devices/cooler/widgets/schedule_btn.dart';
import 'package:chisco/ui/devices/edit/edit_controller.dart';
import 'package:chisco/ui/devices/power/power_screen_controller.dart';
import 'package:chisco/ui/devices/power/widgets/edit_power_bottom_sheet.dart';
import 'package:chisco/ui/devices/power/widgets/power_header.dart';
import 'package:chisco/ui/devices/power/widgets/power_list_item.dart';
import 'package:chisco/ui/devices/schedule/schedule_controller.dart';
import 'package:chisco/ui/devices/widgets/device_appbar.dart';
import 'package:chisco/ui/main/app_controller.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PowerScreen extends StatelessWidget {
  const PowerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final serialNumber = ModalRoute.of(context)!.settings.arguments as String;

    final selectedPower = Provider.of<AppController>(context)
        .getPowerWithSerialNumber(serialNumber);
    print(selectedPower.totalVoltage);
    PowerController controller = Provider.of<PowerController>(context);
    double blueHeight = 0;
    double positionedTopHeight = 0;
    if(height<740){
      blueHeight = 260;
      positionedTopHeight = 220;
    }else{
      blueHeight = ChiscoConverter.calculateWidgetHeight(height,260);
      positionedTopHeight= ChiscoConverter.calculateWidgetHeight(height,220);
    }
    if (controller.initCall) {
      controller.init(selectedPower);
    }
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: blueHeight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(APP_HEADER_BACKGROUND_IMAGE),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Column(
                      children: [
                        DeviceAppBar(
                            onMenuClick: () {
                              Navigator.pushNamed(context, accountPage);
                            },
                            onBackClick: () {
                              Navigator.pushReplacementNamed(context, homePage);
                            },
                            title: 'سه راهی'),
                        Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height * .2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                textDirection: TextDirection.ltr,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            selectedPower.totalVoltage.toString(),
                                        style: const TextStyle(
                                            fontFamily: "ChiscoText",
                                            fontSize: 50,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                    const TextSpan(
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
                        SizedBox(
                            height: ChiscoConverter.calculateWidgetWidth(width, 5)),
                      ],
                    ),
                  ],
                ),
              )),
          Positioned(
              top: positionedTopHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Styles.backGroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                padding: EdgeInsets.symmetric(
                    vertical: ChiscoConverter.calculateWidgetWidth(width, 0),
                    horizontal: ChiscoConverter.calculateWidgetWidth(width, 20)),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: ChiscoConverter.calculateWidgetWidth(width, 20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            width: 34,
                            onClick: () {
                              Navigator.pushNamed(context, schedulePage,
                                  arguments: serialNumber);
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          EditDeviceBtn(
                              width: 34,
                              onClick: () {
                                showChiscoBottomSheet(
                                    context,
                                    ChangeNotifierProvider(
                                      create: (BuildContext context) {
                                        return EditDeviceController(context);
                                      },
                                      child: EditPowerBottomSheet(
                                        selectedPower: selectedPower,
                                      ),
                                    ));
                              }),
                          const SizedBox(
                            width: 10,
                          ),
                          PowerIcon(
                            size: 34,
                            isActive: controller.isPowerActive,
                            onClick: () {
                              controller.onPowerBtnClicked(
                                  selectedPower: selectedPower);
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ChiscoConverter.calculateWidgetWidth(width, 6),
                    ),
                    Expanded(
                        child: ScrollConfiguration(
                      behavior: ChiscoScrollBehavior(),
                      child: ListView.builder(
                        itemCount: selectedPower.connectors.length,
                        shrinkWrap: false,
                        itemBuilder: (context, index) {
                          Connector connector = selectedPower.connectors[index];
                          int connectorId = connector.connectorId;
                          String description = '';
                          if (connectorId <= 4) {
                            description = 'پریز $connectorId';
                          } else {
                            description = 'پورت ${connectorId - 4}';
                          }
                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical: ChiscoConverter.calculateWidgetWidth(
                                  width, 5),
                            ),
                            child: PowerListItem(
                              title: connector.name,
                              description: description,
                              isPower: connector.connectorType == 'power',
                              isActive: connector.status,
                              onChange: (val) {
                                controller.onConnectorChange(
                                    connector.connectorId, val);
                              },
                            ),
                          );
                        },
                      ),
                    ))
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}