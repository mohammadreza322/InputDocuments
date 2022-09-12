import 'dart:ui';

import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';

//todo Blur To Background
// this is method for show bottom sheet in all the project
void showChiscoBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25))),

    barrierColor: Colors.black.withOpacity(0.4),
    backgroundColor: Styles.backGroundColor,

    isScrollControlled: true,
    enableDrag: true,
    isDismissible: true,
    context: context,
    builder: (BuildContext context) {
      //Here BackdropFilter But doesn't work right.....
      return SingleChildScrollView(

        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Padding(
            padding: bottomSheetPaddings,
            child: child,
            //this child is bottom sheet widget
          ),
        ),
      );
    },
  );
}
