import 'package:chisco/data/data_class/CheckOtpResponse.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/GetMobileResponse.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';

abstract class AuthDataSource {

  Future<ChiscoResponse> submitMobile(String number);

  Future<ChiscoResponse> checkUserOtp(String smsId,String code);



  Future<ChiscoResponse> getUserDevices();

  Future<ChiscoResponse> submitUserName(String fullName);

  void saveToken(CheckOtpResponse response) ;




}



