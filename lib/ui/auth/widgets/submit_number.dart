import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/auth/widgets/auth_text_field.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitNumberPage extends StatelessWidget {
  const SubmitNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //todo Remember To Remove Text
    TextEditingController controller = TextEditingController(text: '09011234342');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ChiscoText(
                text: 'شروع با شماره موبایل',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                textColor: Styles.primaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              const ChiscoText(
                  text: 'لطفا اطلاعات خود را برای ورود یا ثبت ‌نام وارد کنید.',
                  fontWeight: FontWeight.w300,
                  textColor: Styles.primaryTextColor),
               SizedBox(
                height:  ChiscoConverter.calculateWidgetWidth(width,45),
              ),
               AuthTextField(
                  label: 'شماره همراه',
                  controller: controller,
                  text: '09012345678',
                  isInputNumber: true,
                  icon: PHONE),
              const SizedBox(
                height: 20,
              ),
              ChiscoButton(
                text: 'دریافت پیامک تایید',
                onClick: () {
                  print("callled 1");
                  Provider.of<AuthController>(context,listen: false).submitNumberBtnClicked(controller.text);
                },
                icon: LEFT_ARROW,
              )
            ],
          ),
        ),
      ),
    );
  }
}
