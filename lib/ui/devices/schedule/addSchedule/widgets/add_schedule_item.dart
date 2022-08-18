import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';

class AddScheduleItem extends StatelessWidget {
  const AddScheduleItem({
    Key? key,
    required this.scheduleWidth,
    required this.scheduleHeight,
    required this.title,
    required this.isActive,
    required this.onClick, this.dayTitle='',

  }) : super(key: key);
  final String? dayTitle;
  final String title;
  final double scheduleWidth;
  final double scheduleHeight;
  final bool isActive;

  final GestureTapCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: scheduleWidth,
        height: scheduleHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [Styles.getBoxShadow(0.07)],
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(width: 1, color: Colors.blueAccent)
              : Border(),
        ),
        child: Center(
          child: ChiscoText(
            fontWeight: FontWeight.w500,
            text: title,
          ),
        ),
      ),
    );
  }
}
