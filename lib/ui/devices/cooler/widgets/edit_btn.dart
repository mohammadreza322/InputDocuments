import 'package:chisco/ui/devices/cooler/widgets/edit_cooler_bottom_sheet.dart';
import 'package:chisco/ui/widget/show_chisco_bottom_sheet.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditCoolerBtn extends StatelessWidget {
  final GestureTapCallback onClick;
  const EditCoolerBtn({
    Key? key,
    required this.width, required this.onClick,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    double parentWidth = MediaQuery.of(context).size.width;

    double iconWidth = (width / 360) * parentWidth;

    return GestureDetector(
      onTap: onClick,
      child: Container(
          width: iconWidth,
          height: iconWidth,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: SvgPicture.asset(SETTING)),
    );
  }
}
