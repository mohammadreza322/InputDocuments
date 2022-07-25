import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  PageController pageViewController = PageController(initialPage: 0,viewportFraction: 1,keepPage: true);

  goToPage(int index) {
    pageViewController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }


}

