import 'dart:async';

import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  bool isPageLoading= false;

  BuildContext context;
  SplashController(this.context) ;

  init() {
    isPageLoading=true;
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }
}
