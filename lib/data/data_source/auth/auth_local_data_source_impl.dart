import 'package:chisco/data/data_class/CheckOtpResponse.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/GetMobileResponse.dart';

import 'package:chisco/data/data_class/MessageResponse.dart';
import 'package:chisco/data/data_source/auth/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

///localDataSourceClass is for process that is local
///for example saving token
class AuthLocalDataSourceImpl implements AuthDataSource {
  final Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();

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
  Future<void> saveToken(
      String accessToken, String refreshToken, String? detail) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", accessToken);
    sharedPreferences.setString("refresh_token", refreshToken);
    if (detail != null) {
      sharedPreferences.setString("detail", detail);
    }
    print("saved Tokens");
  }

  @override
  Future<ChiscoResponse> getUserDevices() {
    // TODO: implement getUserDetails
    throw UnimplementedError();
  }
}
