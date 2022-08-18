import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_icon.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChiscoAppbar extends StatelessWidget {

  final String icon;
  final Alignment iconAlignment;
  final String title;
  final GestureTapCallback onClick;
  const ChiscoAppbar({Key? key, required this.icon, required this.iconAlignment, required this.title, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 40,
      margin: const EdgeInsets.only(top: 23),
      child: Stack(
        children: [
          Align(
            alignment: iconAlignment,
            child: GestureDetector(
              onTap: onClick,
              child: SizedBox(
                  width: 26,
                  height: 26,
                  child: SvgPicture.asset(icon)),
            ),
          ),
           //todo Hard Code Font Size
           Align(
            alignment: Alignment.center,
            child: ChiscoText(
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: Styles.defaultFontSize,
              textColor: Colors.white,
            ),
          ),

        ],
      ),

    );
  }
}
