import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/ui/devices/cooler/cooler_controller.dart';
import 'package:chisco/ui/devices/cooler/widgets/cooler_mode.dart';
import 'package:chisco/ui/devices/cooler/widgets/cooler_controller_item.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_btn.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_cooler_bottom_sheet.dart';
import 'package:chisco/ui/devices/cooler/widgets/schedule_btn.dart';
import 'package:chisco/ui/devices/cooler/widgets/temp_controller.dart';
import 'package:chisco/ui/devices/edit/edit_controller.dart';
import 'package:chisco/ui/devices/widgets/device_appbar.dart';
import 'package:chisco/ui/devices/widgets/device_header.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/power_icon.dart';
import 'package:chisco/ui/widget/show_chisco_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CoolerScreen extends StatelessWidget {
  const CoolerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final serialNumber = ModalRoute.of(context)!.settings.arguments as String;

    CoolerController controller = Provider.of<CoolerController>(context);

    Cooler selectedCooler = Provider.of<AppController>(context)
        .getCoolerWithSerialNumber(serialNumber);
    print(selectedCooler.temp);

    if (controller.initCall) {
      controller.initTemp(selectedCooler);
    }
    controller.init(selectedCooler);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Styles.backGroundColor,
            body: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height:
                          ChiscoConverter.calculateWidgetHeight(height, 200),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(APP_HEADER_BACKGROUND_IMAGE),
                              fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: DeviceAppBar(
                          title: 'کنترلر',
                          onBackClick: () {
                            Navigator.pushReplacementNamed(context, homePage);
                          },
                          onMenuClick: () {
                            Navigator.pushNamed(context, accountPage);
                          },
                        ),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      top: ChiscoConverter.calculateWidgetHeight(height, 70)),
                  padding: EdgeInsets.symmetric(
                    vertical: ChiscoConverter.calculateWidgetWidth(width, 25),
                    horizontal: ChiscoConverter.calculateWidgetWidth(width, 20),
                  ),
                  decoration: const BoxDecoration(
                      color: Styles.backGroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ChiscoText(
                                  text: selectedCooler.name,
                                  fontWeight: FontWeight.w400,
                                ),
                                ChiscoText(
                                  text: selectedCooler.category,
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
                                      child: EditCoolerBottomSheet(
                                        selectedCooler: selectedCooler,
                                      ),
                                    ));
                              }),
                          const SizedBox(
                            width: 10,
                          ),
                          PowerIcon(
                            size: 34,
                            isActive: selectedCooler.power,
                            onClick: () {
                              controller.changeCoolerActive();
                            },
                          )
                        ],
                      ),

                      //Temp Controller
                      Flexible(
                          fit: FlexFit.tight,
                          child: TempController(
                            tempCallBack: (double) {
                              controller.changeTemp(double);
                            },
                          )),

                      const ChiscoText(text: 'حالت های کولر'),
                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [Styles.getBoxShadow(0.07)],
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CoolerMode(
                                icon: autoTest,
                                title: 'خودکار',
                                isSelected: controller
                                    .changeCoolerStateMode(CoolerModes.auto),
                                onClick: () {
                                  controller.changeSelectedCoolerMode(
                                      CoolerModes.auto);
                                },
                              ),
                            ),
                            Expanded(
                              child: CoolerMode(
                                icon: COLD,
                                title: 'سرد',
                                isSelected: controller
                                    .changeCoolerStateMode(CoolerModes.cold),
                                onClick: () {
                                  controller.changeSelectedCoolerMode(
                                      CoolerModes.cold);
                                },
                              ),
                            ),
                            Expanded(
                              child: CoolerMode(
                                icon: heaterTest,
                                title: 'گرم',
                                isSelected: controller
                                    .changeCoolerStateMode(CoolerModes.warm),
                                onClick: () {
                                  controller.changeSelectedCoolerMode(
                                      CoolerModes.warm);
                                },
                              ),
                            ),
                            Expanded(
                              child: CoolerMode(
                                icon: dryTest,
                                title: 'فن',
                                isSelected: controller
                                    .changeCoolerStateMode(CoolerModes.fan),
                                onClick: () {
                                  controller.changeSelectedCoolerMode(
                                      CoolerModes.fan);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.changeHorizontalString();
                              },
                              child: CoolerControllerItem(
                                icon: AIR_FLOW,
                                title: 'چرخش افقی',
                                controllerState: controller.horizontalString,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.changeVerticalString();
                              },
                              child: CoolerControllerItem(
                                icon: SWING,
                                title: 'چرخش عمودی',
                                controllerState: controller.verticalString,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.changeFanSpeedString();
                              },
                              child: CoolerControllerItem(
                                icon: FAN_SPEED,
                                title: 'شدت باد',
                                controllerState: controller.fanSpeedString,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ChiscoText(text: 'زمان سنج خاموشی'),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                controller.changeHourToSleepIncrease();
                              },
                              child: Container(
                                  height: ChiscoConverter.calculateWidgetWidth(
                                      width, 40),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Styles.primaryColor
                                                .withOpacity(0.07),
                                            blurRadius: 15,
                                            offset: const Offset(0, 4))
                                      ]),
                                  child: SvgPicture.asset(PLUS_ICON)),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: ChiscoConverter.calculateWidgetWidth(
                                  width, 40),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Styles.primaryColor
                                            .withOpacity(0.07),
                                        blurRadius: 15,
                                        offset: const Offset(0, 4))
                                  ]),
                              child: Center(
                                  child: ChiscoText(
                                text: controller.hourToSleepTitle,
                                fontWeight: FontWeight.w400,
                              )),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                controller.changeHourToSleepDecrease();
                              },
                              child: Container(
                                height: ChiscoConverter.calculateWidgetWidth(
                                    width, 40),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Styles.primaryColor
                                              .withOpacity(0.07),
                                          blurRadius: 15,
                                          offset: const Offset(0, 4))
                                    ]),
                                child: SvgPicture.asset(MINUS_ICON),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
