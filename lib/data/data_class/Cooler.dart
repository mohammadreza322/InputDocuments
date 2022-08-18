import 'package:chisco/data/data_class/Device.dart';

import 'Schedule.dart';

class Cooler extends Device {
  String brand;
  String fan;
  String horizontalSwing;
  String mode;
  String model;
  String timer;
  String verticalSwing;
  List<Schedule> schedule;

  Cooler(
      {required String name,
      required String category,
      required this.schedule,
      required String serialNumber,
      required this.brand,
      required this.fan,
      required this.horizontalSwing,
      required this.mode,
      required this.model,
      required this.timer,
      required this.verticalSwing})
      : super(
            category: category,
            name: name,
            serialNumber: serialNumber,
            deviceType: DeviceType.cooler);

  factory Cooler.fromJson(Map<String, dynamic> json) {
    return Cooler(
        brand: json['brand'],
        fan: json['fan'],
        horizontalSwing: json['horizontalSwing'],
        mode: json['mode'],
        model: json['model'],
        schedule: json['schedule'] != null ? (json['schedule'] as List).map((e) => Schedule.fromJson(e)).toList() : [],
        name: json['name'],
        category: json['category'],
        serialNumber: json['serialNumber'],
        timer: json['timer'],
        verticalSwing: json['verticalSwing']);
  }
}
