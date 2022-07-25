import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';

class CoolerState extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;

  const CoolerState({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widthSize = (88 / 360) * width;
    double heightSize = (39/797) * height;
    if (isSelected) {
      return Container(
        width: widthSize,
        height: heightSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [Styles.getBoxShadow(0.07)],
            gradient: const LinearGradient(
                colors: [Color(0xff2883D5), Color(0xff1D67BA)])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              color: Colors.white,
            ),
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
    } else {
      return Container(
        width: 88,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              color: Styles.secondaryColor,
            ),
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
      );
    }
  }
}
