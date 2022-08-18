import 'package:flutter/material.dart';



class ChiscoConverter  {
  static calculateWidgetWidth(double parentSize, double widgetSize) {

    return parentSize * (widgetSize / 360);
  }


  static calculateWidgetHeight(double parentSize, double widgetSize) {
    return parentSize * (widgetSize / 767);
  }
}
