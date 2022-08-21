import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/ui/devices/cooler/cooler_controller.dart';
import 'package:chisco/ui/devices/cooler/widgets/cooler_state.dart';
import 'package:chisco/ui/devices/cooler/widgets/cooler_controller_item.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_btn.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_cooler_bottom_sheet.dart';
import 'package:chisco/ui/devices/cooler/widgets/schedule_btn.dart';
import 'package:chisco/ui/devices/cooler/widgets/temp_controller.dart';
import 'package:chisco/ui/devices/widgets/device_appbar.dart';
import 'package:chisco/ui/devices/widgets/device_header.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/power_icon.dart';
import 'package:chisco/ui/widget/show_chisco_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

//todo Clean This Class
class CoolerScreen extends StatelessWidget {
  const CoolerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final selectedCooler = ModalRoute.of(context)!.settings.arguments as Cooler;

    CoolerController controller = Provider.of<CoolerController>(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Styles.backGroundColor,
            body: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height:
                          ChiscoConverter.calculateWidgetHeight(height, 260),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/home_header.png'),
                              fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: DeviceAppBar(
                          title: 'کنترلر',
                          onBackClick: () {Navigator.pop(context);},
                          onMenuClick: () {},
                        ),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      top: ChiscoConverter.calculateWidgetHeight(height, 70)),
                  padding: EdgeInsets.all(16),
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
                              children:  [
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
                            width: 32,
                            onClick: () {
                              Navigator.pushNamed(context, schedulePage,arguments: selectedCooler);
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          EditCoolerBtn(
                              width: 32,
                              onClick: () {
                                showChiscoBottomSheet(
                                    context,EditCoolerBottomSheet(selectedCooler: selectedCooler,));
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

                      //Temp Controller
                      const Flexible(
                          fit: FlexFit.tight, child: TempController()),

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
                              child: CoolerState(
                                icon: AUTO,
                                title: 'خودکار',
                                isSelected:
                                    controller.changeCoolerStateCompareItems(
                                        CoolerStates.auto),
                                onClick: () {
                                  controller.changeSelectedCoolerState(CoolerStates.auto);
                                },
                              ),
                            ),
                            Expanded(
                              child: CoolerState(
                                icon: COLD,
                                title: 'سرد',
                                isSelected:
                                    controller.changeCoolerStateCompareItems(
                                        CoolerStates.cold),
                                onClick: () {
                                  controller.changeSelectedCoolerState(CoolerStates.cold);
                                },
                              ),
                            ),
                            Expanded(
                              child: CoolerState(
                                icon: HEATER,
                                title: 'گرم',
                                isSelected:
                                    controller.changeCoolerStateCompareItems(
                                        CoolerStates.warm),
                                onClick: () {
                                  controller.changeSelectedCoolerState(CoolerStates.warm);
                                },
                              ),
                            ),
                            Expanded(
                              child: CoolerState(
                                icon: FAN,
                                title: 'فن',
                                isSelected:
                                    controller.changeCoolerStateCompareItems(
                                        CoolerStates.fan),
                                onClick: () {
                                  controller.changeSelectedCoolerState(CoolerStates.fan);
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
                        children: const [
                          Expanded(
                            child: CoolerControllerItem(
                              icon: AIR_FLOW,
                              title: 'چرخش افقی',
                              controllerState: 'خاموش',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CoolerControllerItem(
                              icon: SWING,
                              title: 'چرخش عمودی',
                              controllerState: 'سریع',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CoolerControllerItem(
                              icon: FAN_SPEED,
                              title: 'شدت باد',
                              controllerState: 'زیاد',
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
                                child: SvgPicture.asset(
                                    PLUS_ICON) /* Image.asset(
                                  'assets/images/add_icon.png',
                                  color: Styles.secondaryIconColor,
                                ),*/
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
                              //todo X Hour Of
                              child: const Center(
                                  child: ChiscoText(
                                text: '3 ساعت تا خاموشی',
                                fontWeight: FontWeight.w400,
                              )),
                            ),
                          ),
                          Expanded(
                            flex: 1,
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
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
