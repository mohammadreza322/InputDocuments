import 'package:chisco/data/data_class/CheckOtpResponse.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/GetMobileResponse.dart';
import 'package:chisco/data/data_class/TokenSingeleton.dart';

import 'package:chisco/data/data_class/MessageResponse.dart';
import 'package:chisco/data/data_source/auth/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourceImpl implements AuthDataSource{
  final Future<SharedPreferences> sharedPreferences= SharedPreferences.getInstance();

  AuthLocalDataSourceImpl();

  @override
  Future<ChiscoResponse> checkUserOtp(String smsId, String code) {
    // TODO: implement checkOtp
    throw UnimplementedError();
  }

  @override
  Future<ChiscoResponse> submitMobile(String number) {
    // TODO: implement getMobile
    throw UnimplementedError();
  }

  @override
  Future<ChiscoResponse> submitUserName(String fullName) {
    // TODO: implement getUserName
    throw UnimplementedError();
  }

  @override
  Future<ChiscoResponse> refreshToken(String token) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> loadToken() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String accessToken = sharedPreferences.getString("access_token") ?? '';
    final String refreshToken = sharedPreferences.getString("refresh_token") ?? '';
    final String detail = sharedPreferences.getString('detail') ?? '';

    //TokenSingleton().update(accessToken, refreshToken, detail);
  }

  @override
  void saveToken(CheckOtpResponse response) async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("access_token", response.accessToken);
    sharedPreferences.setString("refresh_token", response.refreshToken);
    sharedPreferences.setString("detail", response.details);

    print("saved Tokens");

    loadToken();
  }

  @override
  Future<ChiscoResponse> getUserDevices() {
    // TODO: implement getUserDetails
    throw UnimplementedError();
  }

}