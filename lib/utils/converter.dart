import 'package:flutter/material.dart';

class ChiscoConverter {
  static calculateWidgetWidth(
      BoxConstraints constraints, double parentSize, double widgetSize) {
    double width = constraints.maxWidth;

    return width * (widgetSize / parentSize);
  }


  static calculateWidgetHeight(
      BoxConstraints constraints, double parentSize, double widgetSize) {
    double height = constraints.maxHeight;
    return height * (widgetSize / parentSize);
  }
}
