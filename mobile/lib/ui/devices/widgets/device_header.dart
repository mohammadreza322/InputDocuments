import 'package:chisco/ui/devices/widgets/device_appbar.dart';
import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:flutter/material.dart';

class CoolerScreenHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_header.png'),
              fit: BoxFit.cover
          )),
      child:DeviceAppBar(onBackClick: (){
        Navigator.pop(context);
      },onMenuClick: (){},title: 'کنترلر',),);
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
