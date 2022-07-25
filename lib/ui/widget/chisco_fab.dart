import 'package:chisco/ui/main/theme.dart';
import 'package:flutter/material.dart';

class ChiscoCustomFab extends StatelessWidget {
  final String icon;
  final GestureTapCallback onClick;
  const ChiscoCustomFab({Key? key, required this.icon, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

      onPressed: onClick,
      child: Container(

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [Styles.getBoxShadow(0.35)],
            gradient: const LinearGradient(colors: [Color(0xff2884D6),Color(0xff1D68BB)]),
      image: DecorationImage(image: AssetImage(icon))
        ),

      ),
    );
  }
}
