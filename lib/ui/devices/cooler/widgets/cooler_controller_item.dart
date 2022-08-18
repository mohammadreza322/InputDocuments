import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoolerControllerItem extends StatelessWidget {
  final String icon;
  final String title;
  final String controllerState;

  const CoolerControllerItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.controllerState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(

        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: SvgPicture.asset(
                icon,
                color: Styles.primaryColor,
                ),
            ),
            // const SizedBox(
            //   height: 14,
            // ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ChiscoText(
                  text: title,
                  fontWeight: FontWeight.w400,

                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: ChiscoText(text: controllerState))
          ],
        ),
      ),
    );
  }
}
