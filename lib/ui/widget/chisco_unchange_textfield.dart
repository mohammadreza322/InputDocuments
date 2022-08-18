import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChiscoFixedTextField extends StatelessWidget {
  final String icon;
  final String label;
  final String text;

  const ChiscoFixedTextField(
      {Key? key, required this.icon, required this.label, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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
          SvgPicture.asset(  icon,
            width: 22,
            height: 22,
            color: Styles.secondaryTextColor,),

          const SizedBox(
            width: 12,
          ),
          ChiscoText(
            text: label,
            fontSize: Styles.defaultFontSize,
            fontWeight: FontWeight.w400,
            textColor: Styles.secondaryTextColor,
          ),
          SizedBox(
            width: 4,
          ),
          ChiscoText(
            text: text,
            textColor: Styles.secondaryTextColor,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
