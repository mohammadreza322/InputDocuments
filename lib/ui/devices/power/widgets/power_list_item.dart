import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/converter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PowerListItem extends StatelessWidget {
  final String title;

  final String description;
  final bool isPower;
  final bool isActive;
  final Function(bool) onChange;

  const PowerListItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.isPower,

      required this.isActive, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(
              right: ChiscoConverter.calculateWidgetWidth(width, 40)),
          padding: EdgeInsets.only(
              right: ChiscoConverter.calculateWidgetWidth(width, 24)),
          width: ChiscoConverter.calculateWidgetWidth(width, 320),
          height: ChiscoConverter.calculateWidgetWidth(width, 50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [Styles.getBoxShadow(0.07)]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: ChiscoText(
                text: title,
                fontWeight: FontWeight.w400,
              )),
              ChiscoText(
                text: description,
                fontWeight: FontWeight.w400,
                fontSize: 10,
                textColor: Styles.secondaryTextColor,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Switch(

                    //activeColor: Styles.primaryColor,
                    inactiveThumbColor: Colors.white,
                    // Todo Use Svg if it can be
                    activeThumbImage: const AssetImage(ACTIVE_SWITCH_THUMB),
                    inactiveThumbImage: const AssetImage(OFF_SWITCH_THUMB),

                    activeTrackColor: const Color(0xff34A6F6),
                    inactiveTrackColor: const Color(0xffE2E3E4),
                    key: UniqueKey(),
                    value: isActive,
                    onChanged: onChange),
              )
            ],
          ),
        ),
        Container(
          alignment: FractionalOffset.centerRight,
          padding: const EdgeInsets.all(6),
          width: ChiscoConverter.calculateWidgetWidth(width, 60),
          height: ChiscoConverter.calculateWidgetWidth(width, 60),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffE8F0F9),
          ),
          child: Container(
            width: ChiscoConverter.calculateWidgetWidth(width, 50),
            height: ChiscoConverter.calculateWidgetWidth(width, 50),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xff4B5196).withOpacity(0.15))),
            child: Container(
                margin: EdgeInsets.all(
                    ChiscoConverter.calculateWidgetWidth(width, 12)),
                child: SvgPicture.asset(isPower ? PORT : USB,color: Styles.primaryColor,)),
          ),
        ),
      ],
    );
  }
}
