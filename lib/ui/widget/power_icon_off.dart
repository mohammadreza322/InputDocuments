import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PowerIconOff extends StatelessWidget {
  final double iconWidth;

  final GestureTapCallback onClick;

  const PowerIconOff({Key? key, required this.iconWidth, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double iconSize = (iconWidth / 360) * width;

    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
            color: const Color(0xffEDEDED).withOpacity(0.7),
            boxShadow: [Styles.getBoxShadow(0.07)],
            shape: BoxShape.circle),
        child: Center(
          child: Container(
            width: ((iconWidth - 10) / 360) * width,
            height: ((iconWidth - 10) / 360) * width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffD9D9D9), Color(0xffBDBDBC)]),
                shape: BoxShape.circle),
            child: Center(
                child: SizedBox(
                    width: ((iconWidth - 16) / 360) * width,
                    height: ((iconWidth - 16) / 360) * width,
                    child: SvgPicture.asset(
                      POWER_ICON,
                    ))),
          ),
        ),
      ),
    );
  }
}
