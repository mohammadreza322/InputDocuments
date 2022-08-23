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
    //sharedPreferences.clear();
    String? accessToken = sharedPreferences.getString('access_token');
    isPageLoading = true;

    if (accessToken == null) {
      print('AccessToken Nulllllllllllllllll');
      Timer(const Duration(seconds: 2), () {Navigator.pushReplacementNamed(context, loginPage);
      });
    } else {
      print('Okkkk');
      ChiscoResponse response = await repository.getUserDevices();
      if (response.status) {
        Provider.of<AppController>(context, listen: false).setData(response.object);
        Timer(const Duration(seconds: 2), () {

          Navigator.pushReplacementNamed(context, homePage);

        });
      } else {
        print("Error Message Splash : ${response.errorMessage}");
      }

      print('Okkkk1234');
    }

    //login check
    //get data
  }
}
