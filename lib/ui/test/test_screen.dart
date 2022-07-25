// ignore_for_file: prefer_const_constructors

import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/ui/home/widgets/category_list.dart';
import 'package:chisco/ui/home/widgets/header_item.dart';
import 'package:chisco/ui/home/widgets/home_header.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/test/TestController.dart';
import 'package:chisco/ui/test/test_header.dart';
import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/widgets/home_list.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = Provider.of<AppController>(context);
    String selectedCategory =
        Provider.of<TestController>(context).selectedCategory;

    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: CustomSliverAppBarDelegate(expandedHeight: 220)),
          SliverFillRemaining(
            fillOverscroll: true,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff2884D6), Color(0xff1D68BB)]),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Styles.backGroundColor,

                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8, top: 8),
                          child: const ListHandlerView(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 8, 20, 10),
                        height: 30,
                        child: ListView.builder(

                            physics: BouncingScrollPhysics(),
                            itemCount: appController.listOfDevicesCategory.length,
                            scrollDirection: Axis.horizontal,
                            primary: true,
                            addSemanticIndexes: false,
                            itemBuilder: (context, index) {
                              String category = appController.listOfDevicesCategory[index];
                              return CategoryListItem(
                                isSelected: selectedCategory == category,
                                category: category,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
       /*   SliverToBoxAdapter(
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
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    child: const ListHandlerView(),
                  ),
                ),
              ),
            ),
          ),
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
                  String category = appController.listOfDevicesCategory[index];
                  return CategoryListItem(
                    isSelected: selectedCategory == category,
                    category: category,
                  );
                }),
          )),
          const HomeListContainer()*/
        ],
      )),
    );
  }
}
