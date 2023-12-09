import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleEmptyState extends StatelessWidget {

  const ScheduleEmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(INFO),
        Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const ChiscoText(text: 'هنوز هیچ زمانبندی ثبت نشده')),
        ChiscoText(
          text:
          'برای افزودن از دکمه اضافه کردن زمانبندی در\r\nبالای صفحه استفاده کنید.',
          textAlign: TextAlign.center,
          textColor: Styles.primaryTextColor.withOpacity(0.35),
        )
      ],
    );
  }
}
