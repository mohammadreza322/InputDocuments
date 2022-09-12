import 'package:flutter/material.dart';



class ChiscoConverter  {
  static calculateWidgetWidth(double parentSize, double widgetSize) {

    return parentSize * (widgetSize / 360);

  }


  static calculateWidgetHeight(double parentSize, double widgetSize) {

    return parentSize * (widgetSize / 767);
  }
}


extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}
