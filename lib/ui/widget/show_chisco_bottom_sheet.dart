import 'dart:ui';

import 'package:flutter/material.dart';

void showChiscoBottomSheet(BuildContext context,Widget child){
  showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(25))),
    barrierColor: Colors.black.withOpacity(0.4),

    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {

      return SingleChildScrollView(
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: child,
          ),
        ),
      );
    },
  );
}