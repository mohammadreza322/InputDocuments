import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/ui/home/widgets/category_list.dart';
import 'package:chisco/ui/home/widgets/home_header.dart';
import 'package:chisco/ui/home/widgets/home_list.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_speed_dial.dart';
import 'package:chisco/ui/widget/list_handler.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = Provider.of<AppController>(context);
    String selectedCategory =
        Provider.of<HomeController>(context).selectedCategory;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.backGroundColor,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: HomeHeader(),
              floating: false,
              pinned: false,
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
            //todo Ask Ali For Header
            /*SliverPersistentHeader(delegate: CustomSliverPersistent(),pinned: true,floating: true),*/
            SliverToBoxAdapter(
                child: Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 20, 10),
              height: 30,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: appController.listOfDevicesCategory.length,
                  scrollDirection: Axis.horizontal,
                  primary: true,
                  addSemanticIndexes: false,
                  itemBuilder: (context, index) {
                    String category =
                        appController.listOfDevicesCategory[index];
                    return CategoryListItem(
                      isSelected: selectedCategory == category,
                      category: category,
                    );
                  }),
            )),
            const HomeListContainer()
          ],
        ),
        floatingActionButton: const ChiscoSpeedDial(

            //todo Tell Amir For Fab
            //todo Tell Amir For bottom Sheet with Keyboard
            //todo Tell Amir About Icon Sizes

            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
