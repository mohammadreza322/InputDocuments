import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';

class ChiscoButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onClick;
  final String icon;
  final bool hasIcon;



  const ChiscoButton(
      {Key? key,
      required this.text,
      required this.onClick,
      required this.icon,
      this.hasIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        onClick;
      },
      child: Container(
        //todo HardCode Height Of all Buttons
        height: height*(46/767),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [Styles.getBoxShadow(0.07)],
            gradient: const LinearGradient(
                colors: [Color(0xff2883D5), Color(0xff1D67BA)])),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ChiscoText(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textColor: Colors.white,
          ),

          hasIcon
              ? Image.asset(
                  icon,
                  color: Colors.white,
                )
              : Container()
        ]),
      ),
    );
  }
}
