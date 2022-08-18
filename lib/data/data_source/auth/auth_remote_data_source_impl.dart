import 'package:chisco/data/data_class/CheckOtpResponse.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/GetMobileResponse.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';
import 'package:chisco/data/data_source/auth/auth_data_source.dart';
import 'package:chisco/http_client/httpService.dart';

class AuthRemoteDataSourceImpl implements AuthDataSource {
  final ChiscoClient httpClient = ChiscoClient();

  @override
  Future<ChiscoResponse> checkUserOtp(String smsId, String code) async {
    final response = await httpClient.post(url: 'check-otp', data: {"smsId": smsId, "code": code});
    return response;
  }

  @override
  Future<ChiscoResponse> submitMobile(String number) async {
    final response =await httpClient.post(url: 'get-mobile', data: {"phoneNumber": number});
    print(response.errorMessage);

    return response;
  }

  @override
  Future<ChiscoResponse> submitUserName(String fullName) async {
    final response = await httpClient.post(url: 'user/get-name', data: {"fullName": fullName});
    print(response.object.toString());
    return response;
  }

  @override
  Future<ChiscoResponse> refreshToken(String token) async {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }
  @override
  Future<ChiscoResponse> getUserDevices() async{
    print("response.object");
    final response = await httpClient.get('user');
    print(response.object);
    return response;

  }


  @override
  Future<void> loadToken() async {
    // TODO: implement loadToken
  }

  @override
  void saveToken(CheckOtpResponse response) {
    // TODO: implement saveToken
  }


}
