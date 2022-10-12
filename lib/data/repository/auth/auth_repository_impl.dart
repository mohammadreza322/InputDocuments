import 'package:chisco/data/data_class/CheckOtpResponse.dart';
import 'package:chisco/data/data_class/GetMobileResponse.dart';

import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';
import 'package:chisco/data/data_source/auth/auth_data_source.dart';
import 'package:chisco/data/data_source/auth/auth_local_data_source_impl.dart';
import 'package:chisco/data/data_source/auth/auth_remote_data_source_impl.dart';
import 'package:chisco/data/repository/auth/auth_repository.dart';

import '../../data_class/ChiscoResponse.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authLocalDataSource = AuthLocalDataSourceImpl();
  final AuthDataSource authRemoteDataSource = AuthRemoteDataSourceImpl();

  AuthRepositoryImpl();

  @override
  Future<ChiscoResponse> checkOtp(String smsId, String code) async {
    ChiscoResponse response =
        await authRemoteDataSource.checkUserOtp(smsId, code);
    if (response.status) {
      CheckOtpResponse otpResponse = CheckOtpResponse.fromJson(response.object);

      authLocalDataSource.saveToken(otpResponse.accessToken,
          otpResponse.refreshToken, otpResponse.details);
      ChiscoResponse result = ChiscoResponse(
          status: response.status, code: response.code, object: otpResponse);
      return result;
    } else {
      return response;
    }
  }

  @override
  Future<ChiscoResponse> getMobile(String number) async {
    final response = await authRemoteDataSource.submitMobile(number);
    if (response.status) {
      ChiscoResponse chiscoResponse = ChiscoResponse(
          status: true,
          code: 1,
          object: GetMobileResponse.fromJson(response.object));
      return chiscoResponse;
    } else {
      return response;
    }
  }

  @override
  Future<ChiscoResponse> getUserName(String fullName) async {
    ChiscoResponse response =
        await authRemoteDataSource.submitUserName(fullName);
    if (response.status) {
      ChiscoResponse chiscoResponse = ChiscoResponse(
          status: true,
          code: response.code,
          object: MessageResponse.fromJson(response.object));
      return chiscoResponse;
    } else {
      return response;
    }
  }

  @override
  Future<ChiscoResponse> getUserDevices() async {
    ChiscoResponse response = await authRemoteDataSource.getUserDevices();
    if (response.status) {
      ChiscoResponse result = ChiscoResponse(
          status: true,
          code: response.code,
          object: User.fromJson(response.object));
      return result;
    } else {
      ChiscoResponse result =
          ChiscoResponse(status: false, code: response.code, object: {});
      return result;
    }
  }
}
