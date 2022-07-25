import 'package:chisco/ui/home/widgets/cooler_item.dart';
import 'package:chisco/ui/home/widgets/power_item.dart';
import 'package:flutter/material.dart';

class DeviceGridList extends StatelessWidget {
  const DeviceGridList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(

      delegate: SliverChildBuilderDelegate(

            (context, index) {

          bool isEven = (index % 2) == 0;

          return CoolerListItem(
            coolerTitle: "کولر اتاق پذیرایی",
            coolerDescription: 'اتاق مهمان',
            isActive: true,
            isEven: isEven,
          );
        },
        childCount: 30,
      ),
      //0.93 For Cooler
      //1.23 For Power
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(


        childAspectRatio: 1.15,
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        //mainAxisExtent: 190
      ),
    );
  }
}
