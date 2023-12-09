import 'UserDevices.dart';
/// this data class is contain user details
class UserDetail {
  String address;
  num? birthday;
  String fullName;
  String phoneNumber;


  UserDetail({
    this.address = '',
    this.birthday =null,
    this.fullName ='',
    required this.phoneNumber,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      address: json['address'] != null ? json['address'] : '',
      birthday: json['birthday'],
      fullName: json['fullName'] !=null ?json['fullName']:'',
      phoneNumber: json['phoneNumber'],
    );
  }
}
