import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_source/account/account_data_source.dart';
import 'package:chisco/http_client/httpService.dart';
///this class is as implementation of AccountDataSource

class AccountRemoteDataSource implements AccountDataSource {
  ///http client is for sending request to a server
  final ChiscoClient _httpClient = ChiscoClient();

  @override
  Future<ChiscoResponse> editUserInformation(
      String? location, int? birthday, String? fullName) async {
    ///here we send request
    ChiscoResponse chiscoResponse = await _httpClient.request(
        type: RequestType.put,
        url: 'user/edit',
        data: {
          'birthday': birthday,
          'address': location,
          'fullName': fullName
        });
    print(chiscoResponse.object.toString());
    return chiscoResponse;
  }
}
