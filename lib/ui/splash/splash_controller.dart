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
  bool isSplashEnd= false;
  SplashController(this.context);

  init() async {
    final AuthRepositoryImpl repository = AuthRepositoryImpl();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //sharedPreferences.clear();
    String? accessToken = sharedPreferences.getString('access_token');
    isPageLoading = true;

    if (accessToken == null) {
      print('AccessToken Nulllllllllllllllll');
      progressBarShown = false;
      GlobalVariable.isUserLogin =false;

      return Timer(const Duration(seconds: 2), () {
        print('timer 2');
        Navigator.pushNamedAndRemoveUntil(context, loginPage,(r)=>false);
      });
    } else {
      String? detail = sharedPreferences.getString('detail');
      print(detail);


      ChiscoResponse response = await repository.getUserDevices();
      if (response.status) {
        Provider.of<AppController>(context, listen: false).setData(response.object);
        GlobalVariable.isUserLogin = true;
        Provider.of<AppController>(context, listen: false).connect(topicForSubscribe: 'chisco/test');


        isSplashEnd = true;


      } else {
        progressBarShown = false;
        ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
        print("Error Message Splash : ${response.errorMessage}");
      }

      print('Okkkk1234');
    }

    //login check
    //get data
  }
}
