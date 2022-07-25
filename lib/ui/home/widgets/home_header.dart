import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/home/widgets/header_item.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends SliverPersistentHeaderDelegate {

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return HomeHeaderItems();
  }

  @override
  double get maxExtent => 220;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class HomeHeaderItems extends StatelessWidget {
  const HomeHeaderItems({
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
           Expanded(flex: 1, child: ChiscoAppbar(icon: 'assets/images/menu_icon.png',
                  iconAlignment: Alignment.centerLeft,title: 'خانه' ,onClick: (){
                Navigator.pushNamed(context, '/setting');
                },)),

          const Expanded(
            flex: 3,
            child: Align(
                alignment: Alignment.center,
                child: ChiscoText(
                  text: 'دستگاه‌های هوشمند چیسکو',
                  fontWeight: FontWeight.w600,
                  textColor: Colors.white,
                  fontSize: 16,
                )),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  HeaderItem(
                    titleText: 'کنترلر',
                    icon: 'assets/images/cooler_icon_01.png',
                    counterText: '2',
                  ),
                  HeaderItem(
                    titleText: 'سه راهی',
                    icon: 'assets/images/socket_icon_01.png',
                    counterText: '2',
                  )
                ],
              )),

        ],
      ),
    );
  }
}
