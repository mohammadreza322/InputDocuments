import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChiscoTimeSelector extends StatelessWidget {
  final String icon;
  final String label;
  final String text;
  final bool isHint;
  final GestureTapCallback onClick;

  const ChiscoTimeSelector(
      {Key? key,
      required this.icon,
      required this.label,
      required this.text,
      required this.onClick, this.isHint=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: ChiscoConverter.calculateWidgetWidth(width, buttonHeight),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Styles.primaryColor.withOpacity(0.07),
              offset: Offset(0, 4),
              blurRadius: 15,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            SvgPicture.asset(
              icon,
              width: 22,
              height: 22,
              color: Styles.primaryTextColor,
            ),
            const SizedBox(
              width: 12,
            ),
            ChiscoText(

              text: label,
              fontSize: Styles.defaultFontSize,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              width: 4,
            ),
            ChiscoText(

              text: text,
              textColor: isHint
                  ? Styles.secondaryTextColor
                  : Styles.primaryTextColor,
              fontWeight: isHint? FontWeight.w300 : FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
