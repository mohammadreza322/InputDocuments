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

///its Provider Controller Class for [AccountScreen]
class AccountController extends ChangeNotifier {
  final BuildContext context;

  AccountController(this.context);

  String appVersionString = '';
  UserDetail? userDetail;

  ///here [init] is call for getting app version for showing in bottom of the Screen
  init() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appVersionString = packageInfo.version;
      notifyListeners();
    });

    userDetail = Provider.of<AppController>(context).getUserDetail();
  }

  List<AccountItem> getSettingItems() {
    return [
      ///first item is for editing user detail page after user press this its navigate to ProfilePage
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
        ///after press this we clear the SharePreferences data that contains Tokens
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        sharedPreferences.clear();
        ///after clear sharePreferences we have to change [GlobalVariable.isUserLogin] to false for direct user to [loginPage]
        GlobalVariable.isUserLogin = false;

        Navigator.pushNamedAndRemoveUntil(context, loginPage, (route) => false);
        ChiscoFlushBar.showInfoFlushBar(context, 'از حساب کاربری خود خارج شدید');
      }),

    ];
  }
}

///Data Class for items in this page
class AccountItem {
  final String title;
  final String icon;
  final bool isRed;
  final VoidCallback onClick;

  AccountItem(this.title, this.icon, this.onClick, {this.isRed = false});
}

//Todo Correct Url
final Uri _url = Uri.parse('https://chisco.tech/');

///its a function for launching url when user press buttons
Future<void> chiscoLaunchUrl() async {
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}
