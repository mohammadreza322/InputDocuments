import 'package:chisco/ui/devices/cooler/cooler_screen.dart';
import 'package:chisco/ui/home/homeScreen.dart';
import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/auth/authScreen.dart';
import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/profile/profile_controller.dart';
import 'package:chisco/ui/profile/profile_screen.dart';
import 'package:chisco/ui/setting/settingScreen.dart';
import 'package:chisco/ui/setting/setting_controller.dart';
import 'package:chisco/ui/splash/splashScreen.dart';
import 'package:chisco/ui/splash/splash_controller.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/test/TestController.dart';
import 'package:chisco/ui/test/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = AppController();
    const defaultTextStyle =
        TextStyle(fontFamily: 'ChiscoText', color: Styles.primaryTextColor);

    return ChangeNotifierProvider.value(
      value: appController,
      child: Consumer<AppController>(
        builder: (context, AppController controller, child) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (context, child) => Directionality(
              textDirection: TextDirection.ltr,
              child: Builder(
                builder: (context) => child!,
              ),
            ),
            title: 'Chisco',

            routes: {
              '/login': (context) => ChangeNotifierProvider(
                    child: const AuthScreen(),
                    create: (ctx) => AuthController(),
                  ),
              '/splash': (context) => ChangeNotifierProvider(
                    create: (context) => SplashController(context),
                    child: const SplashScreen(),
                  ),
              '/home': (context) => ChangeNotifierProvider(
                    create: (context) => HomeController(context),
                    child: const Directionality(
                        textDirection: TextDirection.rtl, child: HomeScreen()),
                  ),
              '/setting': (context) => ChangeNotifierProvider(
                    create: (context) => SettingController(context),
                    child: const Directionality(
                        textDirection: TextDirection.rtl,
                        child: SettingScreen()),
                  ),
              '/profile': (context) => ChangeNotifierProvider(
                    create: (context) => ProfileController(),
                    child: const Directionality(
                        textDirection: TextDirection.rtl,
                        child: ProfileScreen()),
                  ),
              '/test': (context) => ChangeNotifierProvider(
                    create: (context) => TestController(context),
                    child: const TestScreen(),
                  ),
              '/devices':(context) => const Directionality(
                textDirection: TextDirection.rtl,
                  child: CoolerControllerScreen())
            },
            initialRoute: '/devices',
            //home: AuthScreen(),
          ),
        ),
      ),
    );
  }
}
