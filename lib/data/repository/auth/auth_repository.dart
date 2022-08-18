import 'package:chisco/data/data_class/CheckOtpResponse.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/GetMobileResponse.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';
abstract class AuthRepository{



  Future<ChiscoResponse> getMobile(String number);

  Future<ChiscoResponse> checkOtp(String smsId,String code);

  Future<ChiscoResponse> refreshToken(String token);


  Future<ChiscoResponse> getUserName(String fullName);

  Future<ChiscoResponse> getUserDevices();




}


