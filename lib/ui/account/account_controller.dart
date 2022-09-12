import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/data/data_class/UserDevices.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/main/global_variable.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountController extends ChangeNotifier {
  final BuildContext context;

  AccountController(this.context);
  bool isLoadingPage = false;
  String appVersionString = '';
  UserDetail? userDetail;
  init(){
    isLoadingPage = true;
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      print('****************************');
      print(packageInfo.buildNumber);
      print(packageInfo.version);
      appVersionString = packageInfo.version;
    });


    userDetail = Provider.of<AppController>(context).getUserDetail();
    print("userDetail from Acc : ${userDetail.toString()}");
  }



  List<AccountItem> getSettingItems() {
    return [
      AccountItem('ویرایش اطلاعات کاربری', EDIT_USER,
          () => Navigator.of(context).pushNamed(profilePage)),
      AccountItem('درباره چیسکو', ABOUT_US, () {
        chiscoLaunchUrl();
      }),
      AccountItem('ورود به سایت', WEB, () {

        chiscoLaunchUrl();
      }),
      AccountItem('شرایط و مقررات', ROLES, () {
        chiscoLaunchUrl();
      }),
      AccountItem('خروج از حساب', LOGOUT, isRed: true, () async {
        SharedPreferences sharedPreferences= await SharedPreferences.getInstance();

        print('Clear Tokens');
        sharedPreferences.clear();
        GlobalVariable.isUserLogin=false;
        Navigator.pushNamedAndRemoveUntil(context, loginPage, (route) => false);
        ChiscoFlushBar.showInfoFlushBar(context, 'از حساب کاربری خود خارج شدید');
      }),
    ];
  }
}

class AccountItem {
  final String title;
  final String icon;
  final bool isRed;
  final VoidCallback onClick;

  AccountItem(this.title, this.icon, this.onClick, {this.isRed = false});
}

//Todo Correct Url
final Uri _url = Uri.parse('https://chisco.tech/');

Future<void> chiscoLaunchUrl() async {
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}
