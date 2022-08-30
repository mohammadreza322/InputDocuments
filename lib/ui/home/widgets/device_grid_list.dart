import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/ui/home/widgets/device_item.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/ui/widget/scroll_behavior.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/data_class/Connector.dart';

class DeviceGridList extends StatelessWidget {
  final ScrollController scrollController;
  final List<Device> devices;

  const DeviceGridList({
    Key? key,
    required this.scrollController,
    required this.devices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);

    double width = MediaQuery.of(context).size.width / 2;
    double height = MediaQuery.of(context).size.height / 3.7;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
            padding: EdgeInsets.only(
                left: ChiscoConverter.calculateWidgetWidth(
                    width, horizontalPadding),
                right: ChiscoConverter.calculateWidgetWidth(
                    width, horizontalPadding)),
            margin: EdgeInsets.symmetric(
                horizontal: ChiscoConverter.calculateWidgetWidth(
                    width, horizontalPadding)),
            child: ScrollConfiguration(
              behavior: ChiscoScrollBehavior(),
              child: Container(
                child: GridView.builder(
                    controller: scrollController,
                    itemCount: devices.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        childAspectRatio: (width / height),
                        mainAxisSpacing: 10,
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      Device device = devices[index];

                      bool isActive = controller.changeDevicePowersBtn(device);
                      return GestureDetector(
                        onTap: () {
                          if (devices[index].deviceType == DeviceType.cooler) {
                            Navigator.pushNamed(context, coolerDevicePage,
                                arguments: devices[index].serialNumber);
                            print("TEMPPP");
                            print(Provider.of<AppController>(context,
                                    listen: false)
                                .getCoolerWithSerialNumber(
                                    devices[index].serialNumber)
                                .temp);
                          } else {
                            Navigator.pushNamed(context, powerDevicePage,
                                arguments: devices[index].serialNumber);
                          }
                        },
                        child: DeviceListItem(
                          deviceTitle: device.name,
                          deviceSerialNumber: device.serialNumber,
                          deviceDescription: device.category,
                          isActive: isActive,
                          isCooler: device.deviceType == DeviceType.cooler,
                          onPowerClick: () {
                            print('ok');
                            controller.onDevicePowerBtnClicked(device);
                          },
                        ),
                      );
                    }),
              ),
            ));
      },
    );
  }
}
