import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';

class DeviceAppBar extends StatelessWidget {
  const DeviceAppBar({Key? key, required this.onMenuClick, required this.onBackClick, required this.title}) : super(key: key);
  final GestureTapCallback onMenuClick;
  final GestureTapCallback onBackClick;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 23),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onMenuClick,
              child: SizedBox(
                  width: 26,
                  height: 26,
                  child: Image.asset('assets/images/menu_icon.png')),
            ),
          ),
          //todo Hard Code Font Size
          Align(
            alignment: Alignment.center,
            child: ChiscoText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              textColor: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,child: SizedBox(
              width: 26,
              height: 26,
              child: Image.asset('assets/images/next_icon.png')),
          )
        ],
      ),

    );

  }
}
