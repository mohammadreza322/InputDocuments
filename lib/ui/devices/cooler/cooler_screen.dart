import 'package:chisco/ui/devices/cooler/widgets/cooler_state.dart';
import 'package:chisco/ui/devices/cooler/widgets/cooler_controller.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_btn.dart';
import 'package:chisco/ui/devices/cooler/widgets/edit_cooler_bottom_sheet.dart';
import 'package:chisco/ui/devices/cooler/widgets/schedule_btn.dart';
import 'package:chisco/ui/devices/widgets/device_header.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/power_icon.dart';
import 'package:chisco/ui/widget/show_chisco_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

//todo Clean This Class
class CoolerControllerScreen extends StatelessWidget {
  const CoolerControllerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double iconWidth = (30 / 360) * width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Styles.backGroundColor,
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: DeviceHeader(),
                  floating: false,
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff2884D6), Color(0xff1D68BB)])),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Styles.backGroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      height: 25,
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: true,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
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
                                children: const [
                                  ChiscoText(
                                    text: 'کولر اتاق پذیرایی',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  ChiscoText(
                                    text: 'اتاق مهمان',
                                    fontWeight: FontWeight.w400,
                                    textColor: Styles.secondaryTextColor,
                                  )
                                ],
                              ),
                            ),
                            scheduleBtn(iconWidth: iconWidth,onClick: (){},),
                            const SizedBox(
                              width: 10,
                            ),
                            EditCoolerBtn(iconWidth: iconWidth,onClick:(){
                              showChiscoBottomSheet(
                                  context, const EditCoolerBottomSheet());
                            }),
                            const SizedBox(
                              width: 10,
                            ),
                            PowerIcon(
                              onClick: () {
                                //todo Power Btn onClick
                              },
                            )
                          ],
                        ),

                        //Temp Controller
                        Expanded(
                            child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const ChiscoText(
                                text: '32°',
                                fontWeight: FontWeight.w400,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: (252 / 350) * width,
                                height: (252 / 350) * width,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE8F0F9),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Styles.primaryColor
                                              .withOpacity(0.20),
                                          offset: const Offset(0, 0),
                                          blurRadius: 20)
                                    ],
                                    shape: BoxShape.circle),
                                child: SleekCircularSlider(
                                  min: 16,
                                  max: 32,
                                  initialValue: 16,
                                  appearance: CircularSliderAppearance(
                                    startAngle: 180,
                                    angleRange: 180,
                                    size: 300 - 30,
                                    customWidths: CustomSliderWidths(
                                      trackWidth: 4,
                                      shadowWidth: 0,
                                      progressBarWidth: 01,
                                      handlerSize: 13,
                                    ),
                                    customColors: CustomSliderColors(
                                      hideShadow: true,
                                      progressBarColor: Colors.transparent,
                                      trackColors: const [
                                        Color(0xffD82148),
                                        Color(0xff34A6F6)
                                      ],
                                      shadowColor:
                                          Color(0xff144FA3).withOpacity(0.25),
                                      shadowMaxOpacity: 0.1,
                                      shadowStep: 0.5,
                                      dotColor: Colors.white,
                                    ),
                                  ),
                                  onChange: (value) {},
                                  innerWidget: (percentage) {
                                    return Container(
                                      margin: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: const Color(0xff4B5196)
                                                  .withOpacity(0.15)),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ChiscoText(
                                                text: '${percentage.toInt()}',
                                                fontSize: 60,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              const ChiscoText(
                                                text: 'تنظیم دمای هوا',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                              const ChiscoText(
                                                text: 'سلسیوس',
                                                textColor:
                                                    Styles.secondaryTextColor,
                                                fontSize: 16,
                                              )
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const ChiscoText(
                                text: '16°',
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
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
                            children: const [
                              CoolerState(
                                  icon: 'assets/images/Auto.png',
                                  title: 'خودکار',
                                  isSelected: true),
                              CoolerState(
                                  icon: 'assets/images/cooler_icon.png',
                                  title: 'خودکار',
                                  isSelected: false),
                              CoolerState(
                                  icon: 'assets/images/heater_icon.png',
                                  title: 'خودکار',
                                  isSelected: false),
                              CoolerState(
                                  icon: 'assets/images/fan_icon.png',
                                  title: 'خودکار',
                                  isSelected: false)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            CoolerController(
                              icon: 'assets/images/air.svg',
                              title: 'چرخش افقی',
                              controllerState: 'خاموش',
                            ),
                            CoolerController(
                              icon: 'assets/images/swing.svg',
                              title: 'چرخش عمودی',
                              controllerState: 'سریع',
                            ),
                            CoolerController(
                              icon: 'assets/images/fan.svg',
                              title: 'شدت باد',
                              controllerState: 'زیاد',
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
                            Container(
                              width: (50 / 360) * width,
                              height: (41 / 767) * height,
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
                              child: Image.asset(
                                'assets/images/add_icon.png',
                                color: const Color(0xff292D32),
                              ),
                            ),
                            Container(
                              width: (204 / 360) * width,
                              height: (41 / 767) * height,
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
                                fontSize: 16,
                              )),
                            ),
                            Container(
                              width: (50 / 360) * width,
                              height: (41 / 767) * height,
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
                              child: Image.asset(
                                'assets/images/minus_icon.png',
                                color: const Color(0xff292D32),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}



class TempController extends StatelessWidget {
  const TempController({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (252 / 350) * width,
      height: (252 / 350) * width,
      decoration: BoxDecoration(
          color: const Color(0xff1D67BA).withOpacity(0.06),
          /*boxShadow: [BoxShadow(
          color: Styles.primaryColor.withOpacity(0.20),
          offset: Offset(0,0),
          blurRadius: 20
        )]*/

          shape: BoxShape.circle),
      child: SleekCircularSlider(
        min: 16,
        max: 32,
        initialValue: 16,
        appearance: CircularSliderAppearance(
          startAngle: 180,
          angleRange: 180,
          size: 300 - 30,
          customWidths: CustomSliderWidths(
            trackWidth: 4,
            shadowWidth: 0,
            progressBarWidth: 01,
            handlerSize: 13,
          ),
          customColors: CustomSliderColors(
            hideShadow: true,
            progressBarColor: Colors.transparent,
            trackColors: const [Color(0xffD82148), Color(0xff34A6F6)],
            dotColor: Colors.white,
          ),
        ),
        onChange: (value) {},
        innerWidget: (percentage) {
          return Container(
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xff4B5196).withOpacity(0.15)),
                shape: BoxShape.circle),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ChiscoText(
                      text: '${percentage.toInt()}',
                      fontSize: 60,
                      fontWeight: FontWeight.w400,
                    ),
                    const ChiscoText(
                      text: 'تنظیم دمای هوا',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    const ChiscoText(
                      text: 'سلسیوس',
                      textColor: Styles.secondaryTextColor,
                      fontSize: 16,
                    )
                  ]),
            ),
          );
        },
      ),
    );
  }
}
