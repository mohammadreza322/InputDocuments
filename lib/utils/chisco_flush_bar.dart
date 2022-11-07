import 'package:another_flushbar/flushbar.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:another_flushbar/flushbar_route.dart' as route;

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

  static Future showAnotherSucces(context) {
    var instance = Flushbar(
      textDirection: TextDirection.ltr,
      margin: EdgeInsets.all(6.0),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.green,
      borderRadius: BorderRadius.circular(12),
      message: 'ریموت کنترل با موفقیت درون دستگاه ثبت شد',
      messageText: Directionality(
        textDirection: TextDirection.rtl,
        child: ChiscoText(
          text: 'ریموت کنترل با موفقیت درون دستگاه ثبت شد',
          textAlign: TextAlign.center,
          textColor: Colors.white,
        ),
      ),
      duration: Duration(seconds: 3),
    );
    final _route = route.showFlushbar(
      context: context,
      flushbar: instance,
    );

    return Navigator.of(context, rootNavigator: true).push(_route);
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

  static showInfoFlushBar(BuildContext context, String message) {
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
