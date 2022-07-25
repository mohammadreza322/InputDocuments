import 'package:chisco/ui/addDevice/add_cooler/add_cooler.dart';
import 'package:chisco/ui/addDevice/add_power/add_power.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/show_chisco_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ChiscoSpeedDial extends StatelessWidget {
  const ChiscoSpeedDial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      visible: true,
      buttonSize: Size(50,50),
      childrenButtonSize: Size(56,56),
      activeChild: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [Styles.getBoxShadow(0.35)],
            gradient: const LinearGradient(
                colors: [Color(0xff2884D6), Color(0xff1D68BB)]),
            image: const DecorationImage(
                image: AssetImage('assets/images/minus_icon.png'))),
      ),
      curve: Curves.bounceInOut,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      children: [
        SpeedDialChild(
          onTap: (){
            showChiscoBottomSheet(context,const AddCoolerBottomSheet());
          },
          child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Styles.primaryColor),
                  image: const DecorationImage(
                    image:
                    AssetImage( 'assets/images/power_icon_primary_color.png'),
                  )
              ),
              ),
          labelWidget: const ChiscoText(
            text: 'اضافه کردن سه راهی',
            textColor: Colors.white,
          ),
        ),
        SpeedDialChild(
          onTap: (){
            showChiscoBottomSheet(context,const AddPowerBottomSheet());
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Styles.primaryColor),
                image: const DecorationImage(
                  image:
                      AssetImage('assets/images/cooler_icon_primary_color.png'),
                )),
          ),
          labelWidget: const ChiscoText(
            text: 'اضافه کردن کنترلر کولر',
            textColor: Colors.white,
          ),
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [Styles.getBoxShadow(0.35)],
            gradient: const LinearGradient(
                colors: [Color(0xff2884D6), Color(0xff1D68BB)]),
            image: const DecorationImage(
              image: AssetImage('assets/images/add_icon.png'),
            )),
      ),

    );
  }
}



