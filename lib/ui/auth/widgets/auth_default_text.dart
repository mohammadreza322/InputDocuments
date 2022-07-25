import 'package:chisco/ui/main/theme.dart';
import 'package:flutter/material.dart';

class AuthDefaultText extends StatelessWidget {
  const AuthDefaultText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =TextStyle(
      color: const Color(0xff06196280).withOpacity(0.5),
    );
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'با ورود و زدن دکمه ادامه، شما با ',
          style: textStyle,
          children:  [
            const TextSpan(

              text: 'شرایط',
              style: TextStyle(color: Styles.primaryTextColor),
            ),
            TextSpan(text: ' و ',style: textStyle),
            const TextSpan(
              text: 'مقررات',
              style: TextStyle(color: Styles.primaryTextColor),
            ),
            TextSpan(text: '\n .ما موافقت کرده‌اید',style: textStyle)
          ]),
    );
  }
}
