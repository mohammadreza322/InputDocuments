import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';

class ChiscoFlushBar{
  static showFlushBar(BuildContext context,String title,String message){

      Flushbar(
        textDirection: TextDirection.rtl,
        title:  title,
        message:  message,
        duration:  Duration(seconds: 3),
      ).show(context);


  }


}