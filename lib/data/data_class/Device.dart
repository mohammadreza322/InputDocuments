import 'dart:convert';

import 'package:chisco/data/data_class/Schedule.dart';

enum DeviceType{cooler,power}
class Device {
final String category;
final String name;
final String serialNumber;



final DeviceType deviceType;
Device.clone(Device device):this(deviceType: device.deviceType,serialNumber: device.serialNumber,category: device.category,name: device.name);

Device(
{required this.category, required this.name, required this.serialNumber,required this.deviceType,});


}
