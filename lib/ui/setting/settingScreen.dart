import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/setting/setting_controller.dart';
import 'package:chisco/ui/setting/setting_header.dart';
import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingController settingController =
        Provider.of<SettingController>(context);
    List<SettingItem> items = settingController.getSettingItems();

    return SafeArea(
        child: Container(
      /*decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Header.png'),
              fit: BoxFit.cover)),*/
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SettingHeader(),
              floating: false,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
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
              ),
            ),

            /*SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
            childCount: items.length,
                    (BuildContext context, int index) {
                  SettingItem item = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff1d67ba).withOpacity(0.07)),
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            item.icon,
                            width: 22,
                            height: 22,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ChiscoText(
                            text: item.title,
                            fontWeight: FontWeight.w400,
                            textColor: item.isRed
                                ? Styles.redColor
                                : Styles.primaryTextColor),
                        Expanded(child: Container()),
                        Image.asset(
                          'assets/images/left_arrow.png',
                          width: 22,
                          height: 22,
                        )
                      ],
                    ),
                  );
                }), itemExtent: 80),*/

            /*SliverList(
              delegate: SliverChildBuilderDelegate(childCount: items.length,
                  (BuildContext context, int index) {
                SettingItem item = items[index];
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff1d67ba).withOpacity(0.07)),
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(8),
                        child: Image.asset(
                          item.icon,
                          width: 22,
                          height: 22,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ChiscoText(
                          text: item.title,
                          fontWeight: FontWeight.w400,
                          textColor: item.isRed
                              ? Styles.redColor
                              : Styles.primaryTextColor),
                      Expanded(child: Container()),
                      Image.asset(
                        'assets/images/left_arrow.png',
                        width: 22,
                        height: 22,
                      )
                    ],
                  ),
                );
              }),
            ),*/
            /*SliverToBoxAdapter(
              child: IntrinsicHeight(child: Container(color: Colors.red,),),
            ),
*/
            SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Column(
                  children: [
                    ...items.map((SettingItem item) {
                      return GestureDetector(
                        onTap: item.onClick,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xff1d67ba).withOpacity(0.07)),
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  item.icon,
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ChiscoText(
                                  text: item.title,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  textColor: item.isRed
                                      ? Styles.redColor
                                      : Styles.primaryTextColor),
                              Expanded(child: Container()),
                              Image.asset(
                                'assets/images/left_arrow.png',
                                width: 30,
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ChiscoText(
                          //todo Get From Server With Some Package
                          text: 'نسخه 1.0.0 طراحی شده در ویوتک',
                          textColor: Styles.primaryTextColor.withOpacity(0.5),
                        ),
                      ),
                    ))
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
