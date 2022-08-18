import 'package:flutter/material.dart';

class PowerController extends ChangeNotifier {
  final BuildContext context;

  PowerController(this.context);

  List<PowerItem> getPowerItems() {
    return [];
  }
}

class PowerItem {
  final String title;
  final String description;
  final String icon;
  final bool isOn;

  PowerItem(
      {required this.title,
      required this.description,
      required this.icon,
      required this.isOn});
}
