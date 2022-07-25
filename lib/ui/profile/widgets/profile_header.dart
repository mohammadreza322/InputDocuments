import 'package:flutter/material.dart';

import '../../widget/chisco_appbar.dart';

class ProfileHeader extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
   return Container(
     padding: const EdgeInsets.symmetric(horizontal: 20),
     decoration: const BoxDecoration(
         image: DecorationImage(
             image: AssetImage('assets/images/Header.png'),
             fit: BoxFit.cover)),
     child: Center(
       child: ChiscoAppbar(icon: 'assets/images/next_icon.png',
         iconAlignment: Alignment.centerRight,title: 'ویرایش اطلاعات کاربری' ,onClick: (){
           Navigator.pop(context);
         },),
     ),

   );
  }

  @override

  double get maxExtent =>80;

  @override

  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
