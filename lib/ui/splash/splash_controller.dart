import 'dart:async';

import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/TokenSingeleton.dart';
import 'package:chisco/data/repository/auth/auth_repository.dart';
import 'package:chisco/data/repository/auth/auth_repository_impl.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ChangeNotifier {
  bool isPageLoading = false;
  BuildContext context;

  SplashController(this.context);

  init() async {
    final AuthRepositoryImpl repository = AuthRepositoryImpl();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? accessToken = sharedPreferences.getString('access_token');
    isPageLoading = true;
    if (accessToken == null) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, loginPage);
      });
    } else {
      print('Okkkk');
      ChiscoResponse userDevices = await repository.getUserDevices();
      Provider.of<AppController>(context, listen: false).setData(userDevices.object);


      print('Okkkk');

      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, homePage);
      });
    }

    //login check
    //get data
  }
}
