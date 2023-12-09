import 'package:chisco/ui/devices/widgets/device_appbar.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';

class PowerScreenHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(APP_HEADER_BACKGROUND_IMAGE),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          DeviceAppBar(
            onBackClick: () {},
            onMenuClick: () {},
            title: 'سه راهی',
          ),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textDirection: TextDirection.ltr,
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '120',
                            style: TextStyle(
                                fontFamily: "ChiscoText",
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        TextSpan(
                            text: ' w',
                            style: TextStyle(
                                fontFamily: "ChiscoText",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const ChiscoText(
                    text: 'ولتاژ لحظه‌ای کل سه راهی',
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                  ),

                ],
              )),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 240;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
