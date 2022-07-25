import 'package:flutter/material.dart';

class scheduleBtn extends StatelessWidget {
  const scheduleBtn({
    Key? key,
    required this.iconWidth, required this.onClick,
  }) : super(key: key);
  final GestureTapCallback onClick;
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
          child: Image.asset('assets/images/timer.png')),
    );
  }
}
