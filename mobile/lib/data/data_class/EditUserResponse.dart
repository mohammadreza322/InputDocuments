import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/data/data_class/UserDevices.dart';
//after editing user this data class will return
class EditUserResponse {
  String message;
  UserDetail details;
  UserDevices devices;

  EditUserResponse(
      {required this.message, required this.details, required this.devices});

  factory EditUserResponse.fromJson(Map<String, dynamic> json) {
    return EditUserResponse(
      message: json['message'],
      details: UserDetail.fromJson(json['user']),
      devices: UserDevices.fromJson(json['devices']),
    );
  }
}
