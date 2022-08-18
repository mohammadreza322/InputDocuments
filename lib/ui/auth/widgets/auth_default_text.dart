import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';
//Todo Role And ... Link
class AuthDefaultText extends StatelessWidget {
  const AuthDefaultText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =TextStyle(
      color: const Color(0xff06196280).withOpacity(0.5),
      fontFamily: 'ChiscoText',
      fontSize: Styles.defaultFontSize,
      fontWeight: Styles.defaultFontWeight
    );
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'با ورود و زدن دکمه ادامه، شما با ',
          style: textStyle,
          children:  [
             TextSpan(
              text: 'شرایط',
              style: textStyle.copyWith(color: Styles.primaryTextColor),
            ),
            TextSpan(text: ' و ',style: textStyle),
             TextSpan(
              text: 'مقررات',
              style: textStyle.copyWith(color: Styles.primaryTextColor),
            ),
            TextSpan(text: '\n .ما موافقت کرده‌اید',style: textStyle)
          ]),
    );
  }
}
