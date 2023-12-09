import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoolerMode extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  final GestureTapCallback onClick;


  const CoolerMode({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected, required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    if (isSelected) {
      return Container(
        height: ChiscoConverter.calculateWidgetWidth(width, 39),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [Styles.getBoxShadow(0.07)],
            gradient: const LinearGradient(
                colors: [Color(0xff2883D5), Color(0xff1D67BA)])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon, color: Colors.white,),
            const SizedBox(
              width: 6,
            ),
            isSelected
                ? ChiscoText(
              text: title,
              textColor: Colors.white,
              fontWeight: FontWeight.w400,
            )
                : Container()
          ],
        ),
      );
    }
    else {
      return InkWell(
        onTap: onClick,
        child: SizedBox(
          height:ChiscoConverter.calculateWidgetWidth(width, 39),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(icon,color: Styles.primaryTextColor,),

              const SizedBox(
                width: 5,
              ),
              isSelected
                  ? ChiscoText(
                text: title,
                textColor: Colors.white,
                fontWeight: FontWeight.w400,
              )
                  : Container()
            ],
          ),
        ),
      );
    }
  }
}
