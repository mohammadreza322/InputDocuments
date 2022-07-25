import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/home/widgets/header_item.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';

class MyCustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/home_header.png'),
              fit: BoxFit.cover)),
      child: Column(
        children: [

          //const Align(alignment: Alignment.topCenter, child: HomeAppBar()),
          const Expanded(

            child: Align(
                alignment: Alignment.center,
                child: ChiscoText(
                  text: 'دستگاه‌های هوشمند چیسکو',
                  fontWeight: FontWeight.w600,
                  textColor: Colors.white,
                  fontSize: 16,
                )),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderItem(titleText: 'کنترلر',
                    icon: 'assets/images/cooler_icon_01.png',
                    counterText: '2',),
                  HeaderItem(titleText: 'سه راهی',
                    icon: 'assets/images/socket_icon_01.png',
                    counterText: '2',)
                ],
              )),
          SizedBox(height: 8,)
        ],
      ),
    );

  }



}