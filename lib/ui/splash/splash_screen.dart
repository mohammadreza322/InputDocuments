import 'dart:async';

import 'package:chisco/ui/auth/authScreen.dart';
import 'package:chisco/ui/splash/splash_controller.dart';
import 'package:chisco/ui/widget/chisco_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashController controller = Provider.of<SplashController>(context);
    if (!controller.isPageLoading) {
      controller.init();
    }

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: controller.progressBarShown
                ? Container(
              margin: const EdgeInsets.only(bottom: 22),
                  child: const CircularProgressIndicator(
                      color: Colors.white,

                    ),
                )
                : Container(),
          )
        ],
      )),
    );
  }
}
