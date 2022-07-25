import 'dart:convert';
import 'dart:ffi';

import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/utils.dart';
import 'package:flutter/material.dart';

class CoolerListItem extends StatelessWidget {
  final String coolerTitle;
  final String coolerDescription;
  final bool isActive;
  final bool isEven;

  const CoolerListItem(
      {Key? key,
      required this.coolerTitle,
      required this.coolerDescription,
      required this.isActive,
      required this.isEven})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = isEven
        ? const EdgeInsets.only(right: 20)
        : const EdgeInsets.only(left: 20);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {

      return Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Styles.primaryColor.withOpacity(0.07),
                offset: Offset(0, 5),
                blurRadius: 15)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Styles.backGroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: (ChiscoConverter.calculateWidgetWidth(
                      constraints, 170, 40)),
                  height: (ChiscoConverter.calculateWidgetHeight(
                      constraints, 170, 40)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 11),
                  child: Image.asset(
                    'assets/images/cooler_icon_primary_color.png',
                    width: 24,
                    height: 18,
                  )),
              SizedBox(
                height:
                    ChiscoConverter.calculateWidgetHeight(constraints, 166, 16),
              ),
              ChiscoText(
                text: coolerTitle,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height:
                    ChiscoConverter.calculateWidgetHeight(constraints, 166, 3),
              ),
              ChiscoText(
                text: coolerDescription,
                fontWeight: FontWeight.w400,
                textColor: Styles.secondaryTextColor,
              ),
              SizedBox(
                height:
                    ChiscoConverter.calculateWidgetHeight(constraints, 166, 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChiscoText(
                    text: isActive ? 'روشن' : 'خاموش',
                  ),
                  Image.asset(
                      isActive
                          ? 'assets/images/Power_Btn.png'
                          : 'assets/images/power_btn_not_active.png',
                      width: ChiscoConverter.calculateWidgetWidth(
                          constraints, 170, 30),
                      height: ChiscoConverter.calculateWidgetHeight(
                          constraints, 170, 30))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
