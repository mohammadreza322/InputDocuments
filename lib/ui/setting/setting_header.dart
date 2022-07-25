import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';

class SettingHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return HeaderItem();
  }

  @override
  double get maxExtent => 220;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class HeaderItem extends StatelessWidget {
  const HeaderItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/home_header.png'),

              fit: BoxFit.cover)),
      child: Column(
        children: [
          Column(
            children: [
              ChiscoAppbar(
                  icon: 'assets/images/next_icon.png',
                  iconAlignment: Alignment.centerRight,
                  title: 'حساب کاربری',
                  onClick:(){Navigator.pop(context);} ),
              SizedBox(height: 30,),
              Image.asset('assets/images/user_icon.png',width: 68,height: 68,),
              SizedBox(height: 10,),
              //todo User Name and Phone Number
              const ChiscoText(
                text: 'مهدی ابوالحسنی',
                textColor: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              const ChiscoText(
                text: '989015335435+',
                textColor: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height:10,)
            ],
          ),
        ],
      ),
    );
  }
}
