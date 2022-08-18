import 'dart:convert';

import 'package:chisco/data/data_class/Schedule.dart';

enum DeviceType{cooler,power}
class Device {
final String category;
final String name;
final String serialNumber;



final DeviceType deviceType;

Device(
{required this.category, required this.name, required this.serialNumber,required this.deviceType,});


}
