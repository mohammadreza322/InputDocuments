import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/main/routes.dart';

import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

final ThemeData androidTheme =
    ThemeData(fontFamily: 'ChiscoText', dividerColor: Colors.transparent);

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  AppController appController = AppController();

  @override
  Widget build(BuildContext context) {
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
                          theme: androidTheme,
                          title: 'Chisco',
                          routes: routes,
                          initialRoute: splashPage,
                          debugShowCheckedModeBanner: false),
                    )));
      },
    );
  }
}
