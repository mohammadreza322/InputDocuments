import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoolerController extends StatelessWidget {
  final String icon;
  final String title;
  final String controllerState;

  const CoolerController({
    Key? key,
    required this.icon,
    required this.title,
    required this.controllerState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double controllerSize = (100 / 360) * width;
    double iconSize = (23 / 360) * width;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      width: controllerSize,
      height: controllerSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: Styles.primaryColor,
            width: iconSize,
            height: iconSize,
          ),
          const SizedBox(
            height: 14,
          ),
          ChiscoText(
            text: title,
            fontWeight: FontWeight.w400,

          ),
          ChiscoText(text: controllerState)
        ],
      ),
    );
  }
}
