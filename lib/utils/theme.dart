import 'package:flutter/material.dart';

class Styles {
  static const secondaryColor = Color(0xff262A35);
  static const secondaryTextColor = Color(0xffB3B6BE);
  static const primaryColor = Color(0xff144FA3);
  static const primaryTextColor = Color(0xff061962);
  static const secondaryIconColor = Color(0xff292D32);
  static const defaultFontSize = 12.0;
  static const defaultFontWeight = FontWeight.w400;
  static const backGroundColor = Color(0xffF5F9FD);


  static const redButtonBackground= Color(0xffD82148);




  static BoxShadow getBoxShadow(double opacity){
    return BoxShadow(
        color: Styles.primaryColor.withOpacity(opacity),
        blurRadius: 15,
        offset: const Offset(0, 4));
  }
}


