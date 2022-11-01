import 'dart:async';

import 'package:chisco/ui/auth/authScreen.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/splash/splash_controller.dart';
import 'package:chisco/ui/widget/chisco_icon.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashController controller = Provider.of<SplashController>(context);
    AppController appController = Provider.of<AppController>(context);
    if (!controller.isPageLoading) {
      controller.init();
    }
    if (controller.isSplashEnd &&
        appController.isMqttConnected &&
        controller.isPageLoading) {
      Timer(const Duration(milliseconds: 250), () {
        controller.progressBarShown = false;
        print('timer 1');
        print("############");
        Navigator.pushNamedAndRemoveUntil(context, homePage, (r) => false);
      });
    }

    if (controller.isPageLoading && !controller.isSplashEnd) {
      Navigator.pushNamedAndRemoveUntil(context, homePage, (r) => false);
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
                    width: 25,
                    height: 25,
                    margin: const EdgeInsets.only(bottom: 22),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  )
                : Container(),
          )
        ],
      )),
    );
  }
}
