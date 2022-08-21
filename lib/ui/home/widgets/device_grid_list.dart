import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/ui/home/widgets/device_item.dart';
import 'package:chisco/ui/widget/scroll_behavior.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';

import 'package:flutter/material.dart';

class DeviceGridList extends StatelessWidget {
  final ScrollController controller;
  final List<Device> devices;

  const DeviceGridList({
    Key? key,
    required this.controller, required this.devices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    double height = MediaQuery.of(context).size.height / 3.8;
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
                    controller: controller,
                    itemCount: devices.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        childAspectRatio: (width / height),
                        mainAxisSpacing: 10,
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      Device device = devices[index];

                      return  GestureDetector(
                        onTap: (){
                          if(devices[index].deviceType==DeviceType.cooler){
                            Navigator.pushNamed(context, coolerDevicePage,arguments: devices[index].serialNumber);
                          }else{
                            Navigator.pushNamed(context, powerDevicePage,arguments: devices[index].serialNumber);
                          }
                        },
                        child: DeviceListItem(
                          coolerTitle: device.name,
                          coolerDescription: device.category,
                          isActive: false,
                          isCooler: device.deviceType==DeviceType.cooler,
                        ),
                      );
                    }),
              ),
            ));
      },
    );
  }
}
