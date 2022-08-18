import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_icon.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return HeaderItem();
  }

  @override
  double get maxExtent => 240;

  @override
  double get minExtent => 240;

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
                  icon: ARROW_RIGHT,
                  iconAlignment: Alignment.centerRight,
                  title: 'حساب کاربری',
                  onClick:(){Navigator.pop(context);} ),
              SizedBox(height: 30,),

              SvgPicture.asset(PROFILE,width: 68,height: 68,),

              SizedBox(height: 10,),
              //todo User Name and Phone Number
              const ChiscoText(
                text: 'مهدی ابوالحسنی',
                textColor: Colors.white,
                fontWeight: FontWeight.w500,

              ),
              SizedBox(height: 4,),

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
