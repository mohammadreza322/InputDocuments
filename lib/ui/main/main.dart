import 'package:chisco/http_client/mqtt/mqtt_controller.dart';
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
import 'package:chisco/ui/main/routes.dart';
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

final ThemeData androidTheme =
    ThemeData(fontFamily: 'ChiscoText', dividerColor: Colors.transparent);

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  AppController appController = AppController();
 // MqttController mqttController = MqttController();
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle =
        TextStyle(fontFamily: 'ChiscoText', color: Styles.primaryTextColor);

    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider<AppController>(create: (_) => AppController()),
              ChangeNotifierProvider<MqttController>(create: (_) => MqttController(context)),

            ],
            child: Consumer<AppController>(
                builder: (context, AppController controller, child) =>
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: MaterialApp(
                        theme: androidTheme,
                        title: 'Chisco',
                        routes: routes,
                        initialRoute: splashPage,
                      ),
                    )));
      },
    );
  }
}
