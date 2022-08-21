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
    final response = await httpClient.request(url: 'check-otp', data: {"smsId": smsId, "code": code});
    return response;
  }

  @override
  Future<ChiscoResponse> submitMobile(String number) async {
    final response =await httpClient.request(url: 'get-mobile', data: {"phoneNumber": number});
    print(response.errorMessage);

    return response;
  }

  @override
  Future<ChiscoResponse> submitUserName(String fullName) async {
    final response = await httpClient.request(url: 'user/get-name', data: {"fullName": fullName});
    print(response.object.toString());
    return response;
  }


  @override
  Future<ChiscoResponse> getUserDevices() async{
    print("response.object");
    final response = await httpClient.request(type: RequestType.get,url:'user');
    print(response.object);
    return response;

  }

  @override
  void saveToken(String accessToken,String refreshToken,String detail) {
    // TODO: implement saveToken
  }


}
