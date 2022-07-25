import 'package:chisco/ui/main/theme.dart';
import 'package:flutter/material.dart';

class ChiscoText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final TextAlign textAlign;
  const ChiscoText(
      {required this.text,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w300,
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
