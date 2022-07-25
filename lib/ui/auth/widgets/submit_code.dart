import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/auth/widgets/auth_text_field.dart';
import 'package:chisco/ui/auth/widgets/otp_code.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/chisco_text.dart';

class SubmitCodePage extends StatelessWidget {
  const SubmitCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ChiscoText(
              text: 'تکمیل ثبت نام',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textColor: Styles.primaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const ChiscoText(
                text: 'لطفا نام و نام خانوادگی خود را وارد کنید.',
                fontSize: 16,
                fontWeight: FontWeight.w300,
                textColor: Styles.primaryTextColor),
            const SizedBox(
              height: 45,
            ),
            Align(
              alignment: Alignment.center,
              child: OtpInput(),
            ),

            const SizedBox(
              height: 20,
            ),
            ChiscoButton(

              text: 'تایید و ورود به چیسکو',
              onClick: () {Provider.of<AuthController>(context,listen: false).goToPage(2);},
              icon: 'assets/images/left_arrow.png',

            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: () {
                    Provider.of<AuthController>(context,listen: false).goToPage(0);
                  },
                  child: const ChiscoText(
                      text: 'برگشت به مرحله قبل',
                      textColor: Styles.primaryTextColor)),
            )
          ],
        ),
      ),
    );
  }
}
