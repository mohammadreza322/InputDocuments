import 'package:chisco/ui/widget/power_icon_off.dart';
import 'package:chisco/ui/widget/power_icon_on.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//todo Size Of Power Btn
class PowerIcon extends StatelessWidget {
  final bool isActive;
  final GestureTapCallback onClick;
  final double size;

  const PowerIcon({Key? key, required this.isActive, required this.onClick, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return PowerIconOn(onClick: onClick, iconWidth: size);
    } else {
      return PowerIconOff(iconWidth: size, onClick: onClick);
    }
  }
}
