import 'package:chisco/data/data_class/UserDevices.dart';
import 'package:chisco/data/data_class/UserDetail.dart';

class User {
  final UserDetail userDetail;
  final UserDevices devices;


  User({required this.userDetail, required this.devices});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      devices: json['devices'] != null ? UserDevices.fromJson(json['devices']) : UserDevices(categories: [], coolers: [], powers: []),
      userDetail: UserDetail.fromJson(json['user']),
    );
  }
}
