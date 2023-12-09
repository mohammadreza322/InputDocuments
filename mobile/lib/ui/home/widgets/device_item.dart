import 'dart:convert';


import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/power_icon.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceListItem extends StatelessWidget {
  final String deviceTitle;
  final String deviceDescription;
  final bool isActive;
  final bool isCooler;
  final Function onPowerClick;
  final String deviceSerialNumber;

  const DeviceListItem({
    Key? key,
    required this.deviceTitle,
    required this.deviceDescription,
    required this.isActive,
    required this.isCooler,
    required this.deviceSerialNumber,
    required this.onPowerClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Styles.primaryColor.withOpacity(0.07),
              offset: const Offset(0, 5),
              blurRadius: 15)
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Styles.backGroundColor,
                  borderRadius: BorderRadius.circular(10)),
              width: ChiscoConverter.calculateWidgetWidth(width, 40),
              height: ChiscoConverter.calculateWidgetWidth(width, 40),
              padding: EdgeInsets.symmetric(
                  vertical: ChiscoConverter.calculateWidgetWidth(width, 6),
                  horizontal: ChiscoConverter.calculateWidgetWidth(width, 8.5)),
              child: SvgPicture.asset(isCooler ? COOLER : SOCKET)),
          SizedBox(height: ChiscoConverter.calculateWidgetWidth(width, 15)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ChiscoText(text: deviceTitle, fontWeight: FontWeight.w500),
              SizedBox(
                height: ChiscoConverter.calculateWidgetWidth(width, 6),
              ),
              ChiscoText(
                text: deviceDescription,
                fontWeight: FontWeight.w400,
                textColor: Styles.secondaryTextColor,
              ),
            ],
          ),
          SizedBox(height: ChiscoConverter.calculateWidgetWidth(width, 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChiscoText(
                text: isActive ? 'روشن' : 'خاموش',
              ),
              PowerIcon(
                size: 30,
                  isActive: isActive,
                  onClick: () {
                    onPowerClick();
                  })
            ],
          ),
        ],
      ),
    );
  }
}
