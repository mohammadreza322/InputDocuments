import 'package:chisco/ui/devices/cooler/widgets/edit_cooler_bottom_sheet.dart';
import 'package:chisco/ui/widget/show_chisco_bottom_sheet.dart';
import 'package:flutter/material.dart';

class EditCoolerBtn extends StatelessWidget {
  final GestureTapCallback onClick;
  const EditCoolerBtn({
    Key? key,
    required this.iconWidth, required this.onClick,
  }) : super(key: key);

  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          width: iconWidth,
          height: iconWidth,
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Image.asset(
            'assets/images/setting.png',
          )),
    );
  }
}
