import 'UserDevices.dart';

class UserDetail {
  final String address;
  final String birthday;
  final String fullName;
  final String phoneNumber;


  UserDetail({
    this.address = '',
    this.birthday = '',
    required this.fullName,
    required this.phoneNumber,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      address: json['address'] != null ? json['address'] : '',
      birthday: json['birthday'] != null ? json['birthday'] :'',
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
