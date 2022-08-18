import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/data/data_class/UserDevices.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountController extends ChangeNotifier {
  final BuildContext context;

  AccountController(this.context);
  bool isLoadingPage = false;

  UserDetail? userDetail;
  init(){
    isLoadingPage = true;
    userDetail = Provider.of<AppController>(context, listen: false).getUserDetail();
    print("userDetail from Acc : ${userDetail.toString()}");
  }


  //Todo Launch Url Problem
  List<AccountItem> getSettingItems() {
    return [
      AccountItem('ویرایش اطلاعات کاربری', EDIT_USER,
          () => Navigator.of(context).pushNamed('/profile')),
      AccountItem('درباره چیسکو', ABOUT_US, () {
        chiscoLaunchUrl();
      }),
      AccountItem('ورود به سایت', WEB, () {
        chiscoLaunchUrl();
      }),
      AccountItem('شرایط و مقررات', ROLES, () {
        chiscoLaunchUrl();
      }),
      AccountItem('خروج از حساب', LOGOUT, isRed: true, () {}),
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
final Uri _url = Uri.parse('https://google.com/');

Future<void> chiscoLaunchUrl() async {
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}
