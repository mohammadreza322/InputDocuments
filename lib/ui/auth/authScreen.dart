import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/auth/widgets/auth_default_text.dart';
import 'package:chisco/ui/auth/widgets/complete_profile.dart';
import 'package:chisco/ui/auth/widgets/submit_code.dart';
import 'package:chisco/ui/auth/widgets/submit_number.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


class AuthScreen extends StatelessWidget {

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   AuthController controller = Provider.of<AuthController>(context);
    return SafeArea(

      child: Scaffold(
        backgroundColor: Styles.backGroundColor,
        bottomNavigationBar: Container(
            height: 50,
            margin:  EdgeInsets.only(bottom:2.h),
            child: const AuthDefaultText()),
        body: Column(
          children: [

            Container(
              margin:  EdgeInsets.only(top: 52),
              child: (Image.asset(OTP_HEADER_PNG)
            )),
             SizedBox(height: ChiscoConverter.calculateWidgetWidth(width,90),),

            Expanded(child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.pageViewController,
              children: const [SubmitNumberPage(),SubmitCodePage(), CompleteProfilePage()],)),

          ],
        ),
      ),
    );
  }
}

