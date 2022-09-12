import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chisco_icon.dart';

class ChiscoButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onClick;
  final String icon;
  final bool hasIcon;
  final bool hasProgressBar;

  const ChiscoButton(
      {Key? key,
      required this.text,
      required this.onClick,
      required this.icon,
      this.hasProgressBar = false,
      this.hasIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onClick,
      child: Container(
        //todo HardCode Height Of all Buttons
        height: ChiscoConverter.calculateWidgetWidth(width, buttonHeight),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [Styles.getBoxShadow(0.07)],
            gradient: const LinearGradient(
                colors: [Color(0xff2883D5), Color(0xff1D67BA)])),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ChiscoText(
            text: text,
            fontSize: Styles.defaultFontSize,
            fontWeight: FontWeight.w500,
            textColor: Colors.white,
          ),
          SizedBox(width: 4,),
          hasProgressBar
              ? const SizedBox(
                width: 20,
                height: 20,
                child: ( CircularProgressIndicator(
                  strokeWidth: 1.5,
                    color: Colors.white,

                  )),
              )
              : hasIcon ? SvgPicture.asset(icon, color: Colors.white,) : Container()
        ]),
      ),
    );
  }
}
