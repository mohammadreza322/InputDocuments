import 'dart:async';
import 'dart:io';

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
import 'package:chisco/ui/main/global_variable.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';

class AuthController extends ChangeNotifier {
  final BuildContext context;
  AuthController(this.context);

  final AuthRepositoryImpl repository = AuthRepositoryImpl();
  TextEditingController enterCodeController = TextEditingController();

  String smsId = '';

  bool isNewUser = true;
  bool hasProgressBar = false;
  String _userPhoneNumber = '';

  PageController pageViewController =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: true);

  setPhoneNumber(String phone) {
    _userPhoneNumber = phone;
    notifyListeners();
  }

  String getUserPhone() {
    return _userPhoneNumber;
  }

  submitNumberBtnClicked(String number) async {
    hasProgressBar = true;
    ChiscoResponse response = await repository.getMobile(number);
    if (!response.status) {
      hasProgressBar = false;
      // print("Error Message is : ${response.errorMessage}");
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
      return;
    }
    hasProgressBar = false;

    GetMobileResponse getMobileResponse = response.object;
    ChiscoFlushBar.showSuccessFlushBar(context, getMobileResponse.message);
    if (!kIsWeb) {
      // print('ok1');
      if (Platform.isAndroid) {
        // print('ok2');

        if (await Permission.sms.request().isGranted) {
          final Telephony telephony = Telephony.instance;
          print("OK3");
          telephony.listenIncomingSms(
              onNewMessage: smsReceivedFunction, listenInBackground: false);
        }
      }
    }

    smsId = getMobileResponse.id;
    isNewUser = getMobileResponse.isNewUser;
    goToPage(1);
  }

  submitCodeBtnClicked(String code) async {
    ChiscoResponse response = await repository.checkOtp(smsId, code);
    if (!response.status) {
      //print("Error Message is : ${response.errorMessage}");
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
      GlobalVariable.isUserLogin = false;

      return;
    } else {
      CheckOtpResponse otpResponse = response.object;
      MessageResponse messageResponse =
          MessageResponse(message: otpResponse.message);
      print("Message Response : ${messageResponse.message}");

      if (isNewUser) {
        goToPage(2);
      } else {
        ChiscoResponse userDevices = await repository.getUserDevices();
        if (!userDevices.status) {
          ChiscoFlushBar.showErrorFlushBar(context, userDevices.errorMessage);
        }
        GlobalVariable.isUserLogin = true;
        await Provider.of<AppController>(context, listen: false)
            .setData(userDevices.object);
        Provider.of<AppController>(context, listen: false)
            .connect(topicForSubscribe: 'chisco/test');
        Navigator.pushReplacementNamed(context, homePage);
        ChiscoFlushBar.showSuccessFlushBar(context, messageResponse.message);

        print("Owwwkke");
      }
    }

    //show Flush
  }

  submitNameBtnClicked(String name) async {
    ChiscoResponse response = await repository.getUserName(name);
    if (!response.status) {
      print("Error Message is : ${response.errorMessage}");
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
      GlobalVariable.isUserLogin = false;
      return;
    }
    MessageResponse messageResponse = response.object;
    ChiscoFlushBar.showSuccessFlushBar(context, messageResponse.message);
    ChiscoResponse userDevices = await repository.getUserDevices();
    GlobalVariable.isUserLogin = true;
    await Provider.of<AppController>(context, listen: false)
        .setData(userDevices.object);
    Provider.of<AppController>(context, listen: false)
        .connect(topicForSubscribe: 'chisco/test');
    Navigator.pushReplacementNamed(context, homePage);
  }

  smsReceivedFunction(SmsMessage receivedMessage) {
    String? message = receivedMessage.body;
    print(message);
    if (message != null) {
      print('not null');
      RegExp isMessageForChiscoRegex = RegExp(r".*چیسکو.*", multiLine: true);
      print(isMessageForChiscoRegex.toString());
      RegExp otpCodeRegex = RegExp(r".*(\d\d\d\d\d).*", multiLine: true);
      print(otpCodeRegex.toString());
      if (isMessageForChiscoRegex.hasMatch(message)) {
        String? otpCode = otpCodeRegex.firstMatch(message)?.group(1);

        if (otpCode == null) {
          print('otp code nullll');
          return;
        }
        print("otpCode");
        print(otpCode);
        enterCodeController.text = otpCode;
        submitCodeBtnClicked(otpCode);
        notifyListeners();
      }
    }
  }

  goToPage(int index) {
    pageViewController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
}
