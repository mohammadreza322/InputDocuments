import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceAppBar extends StatelessWidget {
  const DeviceAppBar({Key? key, required this.onMenuClick, required this.onBackClick, required this.title}) : super(key: key);
  final GestureTapCallback onMenuClick;
  final GestureTapCallback onBackClick;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 40,
      margin: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          GestureDetector(
            onTap: onMenuClick,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                  width: 26,
                  height: 26,
                  child: SvgPicture.asset(MENU)),
            ),
          ),
          //todo Hard Code Font Size
          Align(
            alignment: Alignment.center,
            child: ChiscoText(
              text: title,
              fontWeight: FontWeight.w400,
              textColor: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: onBackClick,
            child: Align(
              alignment: Alignment.centerRight,child: SizedBox(
                width: 26,
                height: 26,
                child: SvgPicture.asset(ARROW_RIGHT)),
            ),
          )
        ],
      ),

    );

  }
}
