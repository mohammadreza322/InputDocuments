import 'package:chisco/ui/home/widgets/cooler_item.dart';
import 'package:chisco/ui/home/widgets/power_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyWowenGridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverMasonryGrid.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        childCount: 100,
        itemBuilder: (context, index) {
          if (index % 2 == 0) {
            return CoolerListItem(
              isEven: index % 2 == 0,
              coolerDescription: 'دستکریپشن ازینا',
              coolerTitle: 'تاتیتل ازینا',
              isActive: true,
            );
          } else {
            return PowerListItem(
              powerItem: "سه راهی یخچال",
              powerDescription: "آشپزخانه",
              isEven: index % 2 == 0,
            );
          }
        });
  }
}
