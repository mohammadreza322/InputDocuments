import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/Schedule.dart';

import 'Connector.dart';

///this data class is use in @userDevice data class (List<Power>)

class Power extends Device {
  bool connectionStatus;
  String category;
  String name;
  List<Schedule> schedule;
  String serialNumber;
  List<Connector> connectors;
  int totalVoltage;
  bool isPowerActive = false;

  Power(
      {required this.category,
      required this.connectors,
      required this.name,
      required this.schedule,
      required this.serialNumber,
      required this.connectionStatus,
      required this.totalVoltage})
      : super(
            name: name,
            category: category,
            serialNumber: serialNumber,
            connectionStatus: connectionStatus
            ,deviceType: DeviceType.power);

  factory Power.fromJson(Map<String, dynamic> json) {
    return Power(
      category: json['category'],
      name: json['name'],
      connectionStatus: json['connectionStatus'],
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

   checkIsPowerActive(){
    List<Connector> connectors = this.connectors.where((element) => element.status).toList();
    if (connectors.isEmpty) {
      print("POWER FALSE");
      isPowerActive= false;
    } else {
      print("POWER TRUE");
      isPowerActive= true;
    }
  }
}
