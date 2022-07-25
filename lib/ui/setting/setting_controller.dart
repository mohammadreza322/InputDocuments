import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class SettingController extends ChangeNotifier{
  final BuildContext context;

  SettingController(this.context);
//Todo Launch Url Problem
  List<SettingItem> getSettingItems() {
    return [
      SettingItem('ویرایش اطلاعات کاربری','assets/images/edit_user.png',() => Navigator.of(context).pushNamed('/profile')),
      SettingItem('درباره چیسکو','assets/images/about_us.png',(){chiscoLaunchUrl();}),
      SettingItem('ورود به سایت','assets/images/web_icon.png',(){chiscoLaunchUrl();}),
      SettingItem('شرایط و مقررات','assets/images/terms_icon.png',(){chiscoLaunchUrl();}),
      SettingItem('خروج از حساب','assets/images/logout_icon.png',isRed: true,(){}),
    ];
  }

}
class SettingItem{
  final String title;
  final String icon;
  final bool isRed;
  final VoidCallback onClick;

  SettingItem(this.title, this.icon, this.onClick, {this.isRed = false});
}
final Uri _url = Uri.parse('https://viaq.ir/');

Future<void> chiscoLaunchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}