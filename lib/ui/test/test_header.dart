import 'package:chisco/ui/home/widgets/header_item.dart';
import 'package:chisco/ui/home/widgets/home_header.dart';
import 'package:chisco/ui/main/main.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print('Shrink $shrinkOffset');
    double percent = 1 - (shrinkOffset / expandedHeight);
    print('Percent  $percent');
    return Stack(
      clipBehavior: Clip.none,

      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset),

        Positioned(
          top: 10,
          left: 10,
          right: 10,
          child: ChiscoAppbar(
            icon: 'assets/images/menu_icon.png',
            iconAlignment: Alignment.centerLeft,
            title: 'خانه',
            onClick: () {
              Navigator.pushNamed(context, '/setting');
            },
          ),
        ),

        Positioned(top: 50, left: 0, right: 0, bottom: 0, child: Opacity(
            opacity: percent,
            child: const HeaderItems()))

        /* Opacity(
            opacity: (percent),
            child: HeaderItems())*/
        // buildAppBar(shrinkOffset),
        //buildFloating(shrinkOffset)
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildBackground(double shrinkOffset) => Image.asset(
        'assets/images/Header.png',
        fit: BoxFit.cover,
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
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
      child: ChiscoAppbar(
        icon: 'assets/images/menu_icon.png',
        iconAlignment: Alignment.centerLeft,
        title: 'خانه',
        onClick: () {
          Navigator.pushNamed(context, '/setting');
        },
      ),
    );
  }
}

class HeaderItems extends StatelessWidget {
  const HeaderItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}

/* Column(children: [
           ChiscoAppbar(
             icon: 'assets/images/menu_icon.png',
             iconAlignment: Alignment.centerLeft,
             title: 'خانه',
             onClick: () {
               Navigator.pushNamed(context, '/setting');
             },
           ),
           Align(

               alignment: Alignment.center,
               child: ChiscoText(
                 text: 'دستگاه‌های هوشمند چیسکو',
                 fontWeight: FontWeight.w600,
                 textColor: Colors.white,
                 fontSize: 16,
               )),
           Align(
             alignment: Alignment.bottomCenter,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: const [
                 HeaderItem(
                   titleText: 'کنترلر',
                   icon: '${Styles.imageAsset}cooler_icon_01.png',
                   counterText: '2',
                 ),
                 HeaderItem(
                   titleText: 'سه راهی',
                   icon: '${Styles.imageAsset}socket_icon_01.png',
                   counterText: '2',
                 )
               ],
             ),
           ),


         ],)*/
