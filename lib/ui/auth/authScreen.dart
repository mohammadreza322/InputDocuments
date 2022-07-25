import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/auth/widgets/auth_default_text.dart';
import 'package:chisco/ui/auth/widgets/complete_profile.dart';
import 'package:chisco/ui/auth/widgets/submit_code.dart';
import 'package:chisco/ui/auth/widgets/submit_number.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AuthScreen extends StatelessWidget {

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   AuthController controller = Provider.of<AuthController>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
          margin: const EdgeInsets.only(bottom: 30),
          child: const AuthDefaultText()),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 52),
              child: (Image.asset('assets/images/login_header.png')),
            ),
            const SizedBox(height: 105,),

            Expanded(child: Directionality(
              textDirection: TextDirection.ltr,
              child: PageView(


                physics: NeverScrollableScrollPhysics(),
                controller: controller.pageViewController,
                children: const [SubmitNumberPage(),SubmitCodePage(), CompleteProfilePage()],),
            )),

          ],
        ),
      ),
    );
  }
}

