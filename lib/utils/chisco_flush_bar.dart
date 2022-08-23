import 'package:another_flushbar/flushbar.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChiscoFlushBar {
  static showSuccessFlushBar(BuildContext context, String message) {
    Flushbar(
      textDirection: TextDirection.ltr,
      margin: EdgeInsets.all(6.0),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.green,
      borderRadius: BorderRadius.circular(12),
      message: message,
      messageText: Directionality(
        textDirection: TextDirection.rtl,
        child: ChiscoText(
          text: message,
          textAlign: TextAlign.center,

          textColor: Colors.white,
        ),
      ),
      duration: Duration(seconds: 3),
    ).show(context);
  }

  static showErrorFlushBar(BuildContext context, String? message) {
    Flushbar(
      textDirection: TextDirection.ltr,
      margin: EdgeInsets.all(6.0),

      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(12),
      backgroundColor: Colors.red,
      message: message,
      messageText: Directionality(
        textDirection: TextDirection.rtl,
        child: ChiscoText(
          textAlign: TextAlign.center,
          text: message!,
          textColor: Colors.white,
        ),
      ),

      duration: Duration(seconds: 3),
    ).show(context);
  }

  static showInfoFlushBar(BuildContext context,String message){
    Flushbar(
      textDirection: TextDirection.ltr,
      margin: EdgeInsets.all(6.0),

      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(12),
      message: message,
      messageText: Directionality(
        textDirection: TextDirection.rtl,
        child: ChiscoText(
          textAlign: TextAlign.center,
          text: message,
          textColor: Colors.white,
        ),
      ),

      duration: Duration(seconds: 3),
    ).show(context);
  }
}
