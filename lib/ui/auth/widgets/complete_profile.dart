import 'package:chisco/ui/auth/widgets/auth_text_field.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_controller.dart';

class CompleteProfilePage extends StatelessWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: "");
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ChiscoText(
              text: 'تکمیل ثبت نام',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              textColor: Styles.primaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const ChiscoText(
                text: 'لطفا نام و نام خانوادگی خود را وارد کنید.',

                fontWeight: FontWeight.w300,
                textColor: Styles.primaryTextColor),
            const SizedBox(
              height: 45,
            ),
             AuthTextField(
                label: 'نام و نام خانوادگی',
                controller: controller,
                text: 'نام شما',
                isInputNumber: false,
                icon: USER),
            const SizedBox(
              height: 20,
            ),
            ChiscoButton(
              text: 'تایید و ورود به چیسکو',
              onClick: (){

                Provider.of<AuthController>(context,listen: false).submitNameBtnClicked(controller.text);

              },
              icon: LEFT_ARROW,
            ),
            const SizedBox(
              height: 15,
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
