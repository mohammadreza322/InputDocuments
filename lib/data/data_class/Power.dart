import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/Schedule.dart';

import 'Connector.dart';

class Power extends Device {
  String category;
  String name;
  List<Schedule> schedule;
  String serialNumber;
  List<Connector> connectors;
  int totalVoltage;

  Power(
      {required this.category,
      required this.connectors,
      required this.name,
      required this.schedule,
      required this.serialNumber,
      required this.totalVoltage})
      : super(
            name: name,
            category: category,
            serialNumber: serialNumber,
            deviceType: DeviceType.power);

  factory Power.fromJson(Map<String, dynamic> json) {
    return Power(
      category: json['category'],
      name: json['name'],
      connectors: json['connectors'] != null
          ? (json['connectors'] as List)
              .map((e) => Connector.fromJson(e))
              .toList()
          : [],
      schedule: json['schedule'] != null
          ? (json['schedule'] as List).map((e) => Schedule.fromJson(e)).toList()
          : [],
      serialNumber: json['serialNumber'],
      totalVoltage: json['totalVoltage'],
    );
  }
}
