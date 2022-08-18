import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//todo Size Of Power Btn
class PowerIconOn extends StatelessWidget {
  final double iconWidth;

  final GestureTapCallback onClick;

  const PowerIconOn({Key? key, required this.onClick, required this.iconWidth})
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
            color: Styles.primaryColor.withOpacity(0.1),
            boxShadow: [Styles.getBoxShadow(0.07)],
            shape: BoxShape.circle),
        child: Center(
          child: Container(
            width: ((iconWidth - 10) / 360) * width,
            height: ((iconWidth - 10) / 360) * width,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xff144FA4), Color(0xff34A6F6)]),
                boxShadow: [Styles.getBoxShadow(0.25)],
                shape: BoxShape.circle),
            child: Center(
                child: SizedBox(
                    width: ((iconWidth - 16) / 360) * width,
                    height: ((iconWidth - 16) / 360) * width,
                    child: SvgPicture.asset(POWER_ICON,))),
          ),
        ),
      ),
    );
  }
}
