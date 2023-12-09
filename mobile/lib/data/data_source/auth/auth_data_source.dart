import 'package:chisco/data/data_class/CheckOtpResponse.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/GetMobileResponse.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';

///this abstract class is for login and all Login methods

abstract class AuthDataSource {
  ///this method is for sending mobile to server
  Future<ChiscoResponse> submitMobile(String number);

  ///this method is for checking code
  Future<ChiscoResponse> checkUserOtp(String smsId,String code);
  ///after successful login we call this method for give all user devices

  Future<ChiscoResponse> getUserDevices();

  ///if user is new we must save his name
  Future<ChiscoResponse> submitUserName(String fullName);

  ///after successful login we save token with this method
  void saveToken(String accessToken,String refreshToken,String detail);

}



