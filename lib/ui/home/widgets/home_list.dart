import 'package:chisco/ui/home/widgets/cooler_item.dart';
import 'package:chisco/ui/home/widgets/device_grid_list.dart';
import 'package:chisco/ui/home/widgets/wowen_grid_list.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/empty_state.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeListContainer extends StatelessWidget {


  const HomeListContainer({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = Provider.of<AppController>(context);

    return appController.isUserHaveDevice()?   DeviceGridList():const SliverToBoxAdapter(
        child: IntrinsicHeight(
          child:
          Align(alignment: Alignment.center, child: EmptyStateView()),
        ));
  }
}
