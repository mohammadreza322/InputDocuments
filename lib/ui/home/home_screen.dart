
import 'package:chisco/ui/home/widgets/header_item.dart';
import 'package:chisco/ui/home/widgets/home_list.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_speed_dial.dart';
import 'package:chisco/ui/widget/chisco_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home_controller.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AppController appController = Provider.of<AppController>(context);
    HomeController homeController = Provider.of<HomeController>(context);
    String selectedCategory = homeController.selectedCategory;
    homeController.homeLists();
    if (!homeController.isPageLoading) {
      print('homeControoller init');
      homeController.init();
    }
    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(APP_HEADER_BACKGROUND_IMAGE),
          alignment: Alignment.topCenter,
        )),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ChiscoAppbar(
                icon: MENU,
                iconAlignment: Alignment.centerLeft,
                title: 'خانه',
                onClick: () {
                  Navigator.pushNamed(context, accountPage);
                },
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * .2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Align(
                            alignment: Alignment.center,
                            child: ChiscoText(
                              text: 'دستگاه‌های هوشمند چیسکو',
                              fontWeight: FontWeight.w500,
                              textColor: Colors.white,
                              fontSize: 16,
                            )),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                HeaderItem(
                                  titleText: 'کنترلر',
                                  icon: COOLER,
                                  counterText: homeController.getCoolerCount
                                      .toString(),
                                ),
                                HeaderItem(
                                  titleText: 'سه راهی',
                                  icon: SOCKET,
                                  counterText:
                                      homeController.getPowerCount.toString(),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              DraggableScrollableSheet(
                expand: true,
                minChildSize: 0.75,
                maxChildSize: 0.98,
                initialChildSize: 0.75,
                builder: (context, scrollController) {
                  return Container(
                      decoration: const BoxDecoration(
                          color: Styles.backGroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: HomeListContainer(
                        controller: scrollController,
                      ));
                },
              )
            ],
          ),
          floatingActionButton: Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: const ChiscoSpeedDial()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startDocked,
        ),
      ),
    );
  }
}
