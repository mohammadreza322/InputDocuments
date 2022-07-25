import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/auth/widgets/auth_text_field.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitNumberPage extends StatelessWidget {
  const SubmitNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ChiscoText(
              text: 'شروع با شماره موبایل',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textColor: Styles.primaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const ChiscoText(
                text: 'لطفا اطلاعات خود را برای ورود یا ثبت‌نام وارد کنید.',
                fontSize: 16,
                fontWeight: FontWeight.w300,
                textColor: Styles.primaryTextColor),
            const SizedBox(
              height: 45,
            ),
            const AuthTextField(
                label: 'شماره همراه',
                controller: null,
                text: '09123456789',
                icon: 'assets/images/phone_icon.png'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                child: ChiscoButton(
              text: 'دریافت پیامک تایید',
              onClick: () {
                Provider.of<AuthController>(context, listen: false).goToPage(1);
              },
              icon: 'assets/images/left_arrow.png',
            ))
          ],
        ),
      ),
    );
  }
}
