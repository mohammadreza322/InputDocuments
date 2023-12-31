import 'dart:async';
import 'dart:convert';

import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/repository/auth/auth_repository.dart';
import 'package:chisco/data/repository/auth/auth_repository_impl.dart';

import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/main/global_variable.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ChangeNotifier {
  bool isPageLoading = false;
  BuildContext context;
  bool progressBarShown = true;
  bool isSplashEnd = false;
  bool isNavigated = false;
  SplashController(this.context);

  bool isLoginPage = true;
  bool isInitCall = false;
  init() async {
    isInitCall = true;
    final AuthRepositoryImpl repository = AuthRepositoryImpl();
    AppController appController = Provider.of<AppController>(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    //notifyListeners();
    //sharedPreferences.clear();
    String? accessToken = sharedPreferences.getString('access_token');
    isPageLoading = true;

    if (accessToken == null) {
      // print('AccessToken Nulllllllllllllllll');
      progressBarShown = false;
      GlobalVariable.isUserLogin = false;

      return Timer(const Duration(milliseconds: 250), () {
        //print('timer 2');
        isPageLoading = true;
        Navigator.pushNamedAndRemoveUntil(context, loginPage, (r) => false);
        // notifyListeners();
      });
    } else {
      String? detail = sharedPreferences.getString('detail');
      //print(detail);

      ChiscoResponse response = await repository.getUserDevices();
      // print(response.code);
      // print(response.errorMessage);

      if (response.status) {

        Provider.of<AppController>(context, listen: false)
            .setData(response.object);
        GlobalVariable.isUserLogin = true;
        Provider.of<AppController>(context, listen: false).connect(topicForSubscribe: 'chisco/test');
        // navigateToHome();

      } else {
        progressBarShown = false;
        GlobalVariable.isUserLogin = false;
        return Timer(const Duration(milliseconds: 250), () {
          //print('timer 2');
          isPageLoading = true;
          Navigator.pushNamedAndRemoveUntil(context, loginPage, (r) => false);
          // notifyListeners();
        });
      }
    }

    //login check
    //get data
  }

  navigateToHome() async {
    isNavigated= true ;
    Timer(const Duration(milliseconds: 200), () {
      isSplashEnd = true;
      isPageLoading = true;
      // if(appController.isMqttConnected &&)
      Navigator.pushNamedAndRemoveUntil(context, homePage, (r) => false);
    });
  }
}
