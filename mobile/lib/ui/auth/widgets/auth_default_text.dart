import 'package:chisco/ui/account/account_controller.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthDefaultText extends StatelessWidget {
  const AuthDefaultText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =TextStyle(
      color:  Styles.primaryTextColor.withOpacity(0.5),
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
              text: 'شرایط و مقررات',
              style: textStyle.copyWith(color: Styles.primaryTextColor),
               recognizer: TapGestureRecognizer()..onTap=(){
                 chiscoLaunchUrl();
               }

            ),

            TextSpan(text: '\n .ما موافقت کرده‌اید',style: textStyle)
          ]),
    );
  }
}
