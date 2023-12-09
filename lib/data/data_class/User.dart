import 'package:chisco/data/data_class/UserDevices.dart';
import 'package:chisco/data/data_class/UserDetail.dart';

///after user successful login Api send this dataClass
class User {
  UserDetail userDetail;
  final UserDevices devices;

  User({required this.userDetail, required this.devices});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      devices: json['devices'] != null ? UserDevices.fromJson(json['devices']) : UserDevices(categories: [], coolers: [], powers: []),
      userDetail: UserDetail.fromJson(json['user']),
    );
  }
}
