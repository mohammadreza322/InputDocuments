import 'dart:ui';

import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';

//todo Blur To Background
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
      return BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 1, sigmaY: 0.1, tileMode: TileMode.clamp),
        child: SingleChildScrollView(
          child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            child: Padding(
              padding: bottomSheetPaddings,
              child: child,
            ),
          ),
        ),
      );
    },
  );
}
