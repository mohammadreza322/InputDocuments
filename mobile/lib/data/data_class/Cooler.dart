import 'package:chisco/data/data_class/Device.dart';

import 'Schedule.dart';
///this data class is use in @userDevice data class (List<Cooler>)
class Cooler extends Device {
  // String brand;
  String fan;
  String horizontalSwing;
  String mode;
  String model;
  String timer;
  String verticalSwing;
  bool power;
  int temp;
  List<Schedule> schedule;

  bool connectionStatus;
  Cooler(
      {required String name,
      required String category,
      required this.schedule,
      required String serialNumber,
      required this.fan,
      required this.horizontalSwing,
      required this.mode,
      required this.model,
      required this.timer,
      required this.verticalSwing,
        required this.temp,
        required this.connectionStatus,
      required this.power})
      : super(
            category: category,
            name: name,
            serialNumber: serialNumber,
            deviceType: DeviceType.cooler,connectionStatus: connectionStatus);

  factory Cooler.fromJson(Map<String, dynamic> json) {
    return Cooler(
        connectionStatus: json['connectionStatus'],
        fan: json['fan'],
        horizontalSwing: json['horizontalSwing'],
        mode: json['mode'],
        model: json['model'],
        schedule: json['schedule'] != null ? (json['schedule'] as List).map((e) => Schedule.fromJson(e)).toList() : [],
        name: json['name'],
        category: json['category'],
        serialNumber: json['serialNumber'],
        timer: json['timer'],
        verticalSwing: json['verticalSwing'],
      power: json['power'],
      temp: json['temp'] !=null ? json['temp'] : 20
    );
  }
}
