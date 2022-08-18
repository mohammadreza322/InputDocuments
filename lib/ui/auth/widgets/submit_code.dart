import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/auth/widgets/auth_text_field.dart';
import 'package:chisco/ui/auth/widgets/otp_code.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/chisco_text.dart';

class SubmitCodePage extends StatelessWidget {
  const SubmitCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =TextEditingController();
    TextStyle textStyle =const TextStyle(
        color: Styles.primaryTextColor,
        fontFamily: 'ChiscoText',
        fontSize: Styles.defaultFontSize,
        fontWeight:FontWeight.w300
    );
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
                text: 'تایید شماره همراه',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textColor: Styles.primaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  textAlign: TextAlign.start,
                  text:  TextSpan(children:[
                TextSpan(text: 'لطفا کد ارسال شده به ',style: textStyle),
                TextSpan(text: '989172223311+',style: textStyle),
                TextSpan(text: ' را وارد کنید.',style: textStyle),

              ]
              )),
              const SizedBox(
                height: 45,
              ),
              Align(
                alignment: Alignment.center,
                child: OtpInput(controller: controller,),
              ),

              const SizedBox(
                height: 20,
              ),
              ChiscoButton(

                text: 'تایید و ورود به چیسکو',
                onClick: () {
                  Provider.of<AuthController>(context, listen: false).submitCodeBtnClicked(controller.text);
                },
                icon: LEFT_ARROW,

              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {
                      Provider.of<AuthController>(context, listen: false)
                          .goToPage(0);
                    },
                    child: const ChiscoText(
                        text: 'برگشت به مرحله قبل',
                        textColor: Styles.primaryTextColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
