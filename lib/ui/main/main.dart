import 'package:chisco/ui/devices/cooler/cooler_controller.dart';
import 'package:chisco/ui/devices/cooler/cooler_screen.dart';
import 'package:chisco/ui/devices/power/power_screen.dart';
import 'package:chisco/ui/devices/schedule/addSchedule/add_schedule_controller.dart';
import 'package:chisco/ui/devices/schedule/schedule_controller.dart';
import 'package:chisco/ui/devices/schedule/schedule_screen.dart';
import 'package:chisco/ui/home/home_screen.dart';
import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/auth/authScreen.dart';
import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/main/test.dart';
import 'package:chisco/ui/profile/profile_controller.dart';
import 'package:chisco/ui/profile/profile_screen.dart';
import 'package:chisco/ui/account/account_screen.dart';
import 'package:chisco/ui/account/account_controller.dart';
import 'package:chisco/ui/splash/splash_screen.dart';
import 'package:chisco/ui/splash/splash_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../devices/schedule/addSchedule/add_schedule.dart';
import '../widget/scroll_behavior.dart';

final ThemeData androidTheme =
    ThemeData(fontFamily: 'ChiscoText', dividerColor: Colors.transparent);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = AppController();
    const defaultTextStyle =
        TextStyle(fontFamily: 'ChiscoText', color: Styles.primaryTextColor);

    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return ChangeNotifierProvider.value(
          value: appController,
          child: Consumer<AppController>(
            builder: (context, AppController controller, child) =>
                GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },

              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: androidTheme,
                title: 'Chisco',
                routes: {
                  loginPage: (context) => ChangeNotifierProvider(
                        child: const AuthScreen(),
                        create: (ctx) => AuthController(context),
                      ),
                  splashPage: (context) => ChangeNotifierProvider(
                        create: (context) => SplashController(context),
                        child: const SplashScreen(),
                      ),
                  homePage: (context) => ChangeNotifierProvider(
                        create: (context) => HomeController(context),
                        child: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: HomeScreen()),
                      ),
                  accountPage: (context) => ChangeNotifierProvider(
                        create: (context) => AccountController(context),
                        child: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: AccountScreen()),
                      ),
                  profilePage: (context) => ChangeNotifierProvider(
                        create: (context) => ProfileController(context),
                        child: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: ProfileScreen()),
                      ),
                  coolerDevicePage: (context) => ChangeNotifierProvider(
                        create: (BuildContext context) => CoolerController(context),
                        child: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: CoolerScreen()),
                      ),
                  schedulePage: (context) => ChangeNotifierProvider(
                        create: (BuildContext context) =>
                            ScheduleController(context),
                        child: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: ScheduleScreen()),
                      ),
                  powerDevicePage: (context) => const Directionality(
                      textDirection: TextDirection.rtl, child: PowerScreen()),
                  testPage: (context) => ChangeNotifierProvider(
                        create: (context) => HomeController(context),
                        child: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: TestScreen()),
                      ),
                },
                initialRoute: splashPage,
              ),
            ),
          ),
        );
      },
    );
  }
}
