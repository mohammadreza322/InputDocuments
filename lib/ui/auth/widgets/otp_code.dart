import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ChiscoText(text: 'کد دریابفت شده', textColor: Styles.primaryTextColor),
        const SizedBox(height: 10,),
        OtpTextField(
          numberOfFields: 5,
        fieldWidth: 41,
        borderRadius: BorderRadius.circular(12),
          margin: EdgeInsets.only(left: 7,right: 7),
          borderWidth: 0,

        keyboardType: TextInputType.number,
          decoration: InputDecoration(



            fillColor: Colors.white,

            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),

          ),
        //set to true to show as box or false to show as dash
          showFieldAsBox: true,


        //runs when a code is typed in
          onCodeChanged: (String code) {
        //handle validation or checks here
          },
        //runs when every textfield is filled
          onSubmit: (String verificationCode) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),
                  );
                });
          }, // end onSubmit
        ),
      ],
    );
  }
}
