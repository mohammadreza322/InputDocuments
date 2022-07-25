import 'package:chisco/ui/home/widgets/category_list.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/material.dart';

class CustomSliverPersistent extends SliverPersistentHeaderDelegate{




  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
   return Container(
     decoration: const BoxDecoration(
         gradient: LinearGradient(
             colors: [Color(0xff2884D6), Color(0xff1D68BB)])),
     child: Container(
       decoration: const BoxDecoration(
           color: Styles.backGroundColor,
           borderRadius: BorderRadius.only(
               topLeft: Radius.circular(25),
               topRight: Radius.circular(25))),
       height: 40,
       child: Center(
         child: Container(
           margin: const EdgeInsets.only(bottom: 8, top: 8),
           child: const ListHandlerView(),
         ),
       ),
     ),
   );
  }

  @override

  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
   return true;
  }


}