import 'dart:convert';

import 'package:chisco/data/data_class/Schedule.dart';

///parent of @Cooler and @Power data class,
enum DeviceType { cooler, power }

class Device {
  final String category;
  final String name;
  final String serialNumber;
  final bool connectionStatus;
  final DeviceType deviceType;

  Device.clone(Device device)
      : this(
            connectionStatus: device.connectionStatus,
            deviceType: device.deviceType,
            serialNumber: device.serialNumber,
            category: device.category,
            name: device.name);

  Device({
    required this.connectionStatus,
    required this.category,
    required this.name,
    required this.serialNumber,
    required this.deviceType,
  });
}
