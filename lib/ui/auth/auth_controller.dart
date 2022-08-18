import 'dart:async';

import 'package:chisco/data/data_class/CheckOtpResponse.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/GetMobileResponse.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';
import 'package:chisco/data/data_source/auth/auth_local_data_source_impl.dart';
import 'package:chisco/data/data_source/auth/auth_remote_data_source_impl.dart';
import 'package:chisco/data/repository/auth/auth_repository.dart';
import 'package:chisco/data/repository/auth/auth_repository_impl.dart';
import 'package:chisco/http_client/httpService.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthController extends ChangeNotifier {
  final BuildContext context;
  final AuthRepositoryImpl repository = AuthRepositoryImpl();
  String smsId = '';
  bool isNewUser = true;

  AuthController(this.context);

  PageController pageViewController = PageController(initialPage: 0, viewportFraction: 1, keepPage: true);


  submitNumberBtnClicked(String number) async {
    print("called 2");
    ChiscoResponse response = await repository.getMobile(number);
    if (!response.status) {
      //FlushBar
      //return
      print("Error Message is : ${response.errorMessage}");
      return;
    }

    GetMobileResponse getMobileResponse = response.object;
    smsId = getMobileResponse.id;
    isNewUser = getMobileResponse.isNewUser;
    goToPage(1);
  }

  submitCodeBtnClicked(String code) async {
    ChiscoResponse response = await repository.checkOtp(smsId, code);
    if (!response.status) {
      //FlushBar
      //return
      print("Error Message is : ${response.errorMessage}");

      return;
    }
    CheckOtpResponse otpResponse = response.object;

    MessageResponse messageResponse = MessageResponse(message: otpResponse.message);
    print("Message Response : ${messageResponse.message}");
    if(isNewUser){
      goToPage(2);
    }else{
      ChiscoResponse userDevices = await repository.getUserDevices();
      await Provider.of<AppController>(context, listen: false).setData(userDevices.object);
      Navigator.pushReplacementNamed(context, homePage);
    }
    //show Flush
  }

  submitNameBtnClicked(String name) async {
    ChiscoResponse response = await repository.getUserName(name);
    if (!response.status) {
      print("Error Message is : ${response.errorMessage}");
      return;
    }
    ChiscoResponse userDevices = await repository.getUserDevices();
    await Provider.of<AppController>(context, listen: false).setData(userDevices.object);

    // print("Print From Controller : ${userDevices.object.toString()}");
    MessageResponse messageResponse = response.object;
    //print("Message Response : ${messageResponse.message}");
    Navigator.pushReplacementNamed(context, homePage);
  }


  goToPage(int index) {
    pageViewController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
}
