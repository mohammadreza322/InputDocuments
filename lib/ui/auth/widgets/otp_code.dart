import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller ;
  const OtpInput({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ChiscoText(
            text: 'کد دریافت شده', textColor: Styles.primaryTextColor),
        const SizedBox(
          height: 10,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Pinput(
            controller: controller,

            length: 5,

            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,

            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
           onCompleted: (pin){
              print(pin);
              Provider.of<AuthController>(context,listen: false).submitCodeBtnClicked(pin);
           },
          )
        )
      ],
    );
  }
}

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(fontSize: 15,fontFamily: 'ChiscoText', color: Color(0xff061962), fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
      color: Colors.white,
    boxShadow: [Styles.getBoxShadow(0.07)],
    border: const Border.fromBorderSide(BorderSide.none),
    borderRadius: BorderRadius.circular(16),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: const Color(0xff2379CB)),


);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: Colors.white,

  ),
);
