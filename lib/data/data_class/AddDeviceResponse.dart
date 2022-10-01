import 'package:chisco/data/data_class/UserDevices.dart';

///after adding device this data class will response

class AddDeviceResponse {

  final String message;
  final UserDevices devices;

  AddDeviceResponse(this.message, this.devices);

  factory AddDeviceResponse.fromJson(Map<String, dynamic> json){
    return AddDeviceResponse(json['message'], json['devices'] != null
        ? UserDevices.fromJson(json['devices'])
        : UserDevices(categories: [], coolers: [], powers: []),);

  }
}