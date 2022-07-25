import 'package:chisco/ui/main/theme.dart';
import 'package:flutter/material.dart';

//todo Size Of Power Btn
class PowerIcon extends StatelessWidget {
  final GestureTapCallback onClick ;
  const PowerIcon({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double iconSize = (30 / 360) * width;
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
            width: (20 / 360) * width,
            height: (20 / 360) * width,
            decoration: BoxDecoration(

                gradient: const LinearGradient(
                    colors: [Color(0xff144FA4), Color(0xff34A6F6)]),
                boxShadow: [Styles.getBoxShadow(0.25)],
                shape: BoxShape.circle),
            child: Center(child: Container(
                width: (16 / 360) * width,
                height: (16 / 360) * width,

                child: Image.asset('assets/images/power_icon.png'))),
          ),
        ),
      ),
    );
  }
}
