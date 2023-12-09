
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:chisco/utils/theme.dart';
class AuthOtp extends StatelessWidget {

  const AuthOtp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChiscoText(
          text: "label",
          textColor: Styles.primaryTextColor,
        ),
      ],
    );
  }
}
