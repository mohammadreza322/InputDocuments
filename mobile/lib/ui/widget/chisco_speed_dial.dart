import 'package:chisco/ui/add_device/add_cooler/add_cooler.dart';
import 'package:chisco/ui/add_device/add_power/add_power.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/show_chisco_bottom_sheet.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';

class ChiscoSpeedDial extends StatelessWidget {
  const ChiscoSpeedDial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SpeedDial(
      onOpen: (){
        // print('open');
        },
      onClose: (){
        // print('close');
      },

      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      visible: true,
      spaceBetweenChildren: 4,
      curve: Curves.bounceIn,
      elevation: 8.0,
      //childMargin: EdgeInsets.all( 50),
      // childPadding: EdgeInsets.only(left: ChiscoConverter.calculateWidgetWidth(width, 5)),
      //childMargin: EdgeInsets.only(left:  ChiscoConverter.calculateWidgetWidth(width,5)),
      buttonSize: Size(ChiscoConverter.calculateWidgetWidth(width, 45),
          ChiscoConverter.calculateWidgetWidth(width, 45)),

      childrenButtonSize: Size(ChiscoConverter.calculateWidgetWidth(width, 50),
          ChiscoConverter.calculateWidgetWidth(width, 50)),

      children: [
        SpeedDialChild(
          onTap: () {
            showChiscoBottomSheet(context, const AddPowerBottomSheet());
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //border: Border.all(color: Styles.primaryColor),
            ),
            child: SvgPicture.asset(
              ADD_POWER_ICON,
            ),
          ),
          labelWidget: const ChiscoText(
            text: 'اضافه کردن سه راهی',
            textColor: Colors.white,
          ),
        ),
        SpeedDialChild(
          onTap: () {
            showChiscoBottomSheet(context, const AddCoolerBottomSheet());
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              //  border: Border.all(color: Styles.primaryColor),
            ),
            child: SvgPicture.asset(
              ADD_COOLER_ICON,
            ),
          ),
          labelWidget: const ChiscoText(
            text: 'اضافه کردن کنترلر کولر',
            textColor: Colors.white,
          ),
        ),
      ],
      activeChild: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color(0xff2B8BDD),
                Color(0xff1B61B4),
              ])),
          child: SvgPicture.asset(
            MINUS_ICON,
            width: double.infinity,
            color: Colors.white,
          ) /*Image.asset(
          'assets/images/minus_icon.png',
          width: double.infinity,
        ),*/
          ),
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color(0xff2B8BDD),
                Color(0xff1B61B4),
              ])),
          child: SvgPicture.asset(
            PLUS_ICON,
            width: double.infinity,
            color: Colors.white,
          )
          /*  child: Image.asset(
          'assets/images/add_icon.png',
          width: double.infinity,
        ),*/
          ),
    );
  }
}
