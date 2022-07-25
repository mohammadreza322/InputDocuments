import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/info-circle.png'),
        Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const ChiscoText(text: 'هنوز هیچ دستگاهی ثبت نشده')),
         ChiscoText(
          text:
              'برای افزودن از دکمه اضافه کردن دستگاه در\r\nکنار صفحه استفاده کنید.',
          textAlign: TextAlign.center,
          textColor: Styles.primaryTextColor.withOpacity(0.35),
        )
      ],
    );
  }
}
