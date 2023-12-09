import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';

class ChiscoText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final TextAlign textAlign;
  const ChiscoText(
      {required this.text,
      this.fontSize = Styles.defaultFontSize,
      this.fontWeight = Styles.defaultFontWeight,
      this.textAlign = TextAlign.start,

         Key? key,
      this.textColor = Styles.primaryTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

      text,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
          fontFamily: 'ChiscoText'),
      textAlign: textAlign,
    );
  }
}
