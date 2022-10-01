import 'package:chisco/ui/devices/power/power_screen_controller.dart';
import 'package:chisco/ui/main/conditional_router.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chisco/ui/devices/cooler/cooler_controller.dart';
import 'package:chisco/ui/devices/cooler/cooler_screen.dart';
import 'package:chisco/ui/devices/power/power_screen.dart';
import 'package:chisco/ui/devices/schedule/schedule_controller.dart';
import 'package:chisco/ui/devices/schedule/schedule_screen.dart';
import 'package:chisco/ui/home/home_screen.dart';
import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/ui/auth/authScreen.dart';
import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/profile/profile_controller.dart';
import 'package:chisco/ui/profile/profile_screen.dart';
import 'package:chisco/ui/account/account_screen.dart';
import 'package:chisco/ui/account/account_controller.dart';
import 'package:chisco/ui/splash/splash_screen.dart';
import 'package:chisco/ui/splash/splash_controller.dart';
import 'package:chisco/utils/const.dart';

///here we highlighting our routes
var splashScreenPage = ChangeNotifierProvider(
  create: (context) => SplashController(context),
  child: const SplashScreen(),
);

var routes = ConditionalRouter(public: {
  splashPage: (context) => splashScreenPage,
  loginPage: (context) => ChangeNotifierProvider(
        child: const AuthScreen(),
        create: (ctx) => AuthController(context),
      ),
}, private: {
  homePage: (context) => ChangeNotifierProvider(
        create: (context) => HomeController(context),
        child: const Directionality(
            textDirection: TextDirection.rtl, child: HomeScreen()),
      ),
  accountPage: (context) => ChangeNotifierProvider(
        create: (context) => AccountController(context),
        child: const Directionality(
            textDirection: TextDirection.rtl, child: AccountScreen()),
      ),
  profilePage: (context) => ChangeNotifierProvider(
        create: (context) => ProfileController(context),
        child: const Directionality(
            textDirection: TextDirection.rtl, child: ProfileScreen()),
      ),
  coolerDevicePage: (context) {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      print("////////////////////////");
      print(ModalRoute.of(context)!.settings.arguments);
      return splashScreenPage;
    }
    return ChangeNotifierProvider(
      create: (BuildContext context) => CoolerController(context),
      child: const Directionality(
          textDirection: TextDirection.rtl, child: CoolerScreen()),
    );
  },
  schedulePage: (context) {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      return splashScreenPage;
    }

    return ChangeNotifierProvider(
      create: (BuildContext context) => ScheduleController(context),
      child: const Directionality(
          textDirection: TextDirection.rtl, child: ScheduleScreen()),
    );
  },
  powerDevicePage: (context) {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      return splashScreenPage;
    }
    return ChangeNotifierProvider(
      create: (BuildContext context) => PowerController(context),
      child: const Directionality(
          textDirection: TextDirection.rtl, child: PowerScreen()),
    );
  },
});
