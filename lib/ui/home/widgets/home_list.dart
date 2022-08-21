import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/ui/home/widgets/category_list.dart';
import 'package:chisco/ui/home/widgets/device_item.dart';
import 'package:chisco/ui/home/widgets/device_grid_list.dart';

import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/empty_state.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../utils/const.dart';

class HomeListContainer extends StatelessWidget {
  final ScrollController controller;

  const HomeListContainer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    AppController appController = Provider.of<AppController>(context);
    HomeController homeController = Provider.of<HomeController>(context);
    String selectedCategory = homeController.selectedCategory;
    //print('Category     ${appController.getCategories.toString()}');
    if (appController.isUserHaveDevice()) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListHandlerView(),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: ChiscoConverter.calculateWidgetWidth(width, 10),
                horizontal: ChiscoConverter.calculateWidgetWidth(
                    width, horizontalPadding)),
            height: 30,
            child: ListView.builder(
                shrinkWrap: false,
                physics: const BouncingScrollPhysics(),
                itemCount: homeController.categories.length,
                scrollDirection: Axis.horizontal,
                primary: true,
                addSemanticIndexes: false,
                itemBuilder: (context, index) {
                  String category =homeController.categories[index];
                  return CategoryListItem(
                    isSelected: selectedCategory == category,
                    category: category,
                  );
                }),
          ),
          Expanded(
            child: DeviceGridList(
              controller: controller,
              devices: homeController.filteredDevices,
            ),
          ),
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            color: Styles.backGroundColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25))),
        child: const IntrinsicHeight(
          child: Align(alignment: Alignment.center, child: EmptyStateView()),
        ),
      );
    }
  }
}
