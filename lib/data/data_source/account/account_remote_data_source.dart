import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_source/account/account_data_source.dart';
import 'package:chisco/http_client/httpService.dart';

class AccountRemoteDataSource implements AccountDataSource {
  final ChiscoClient _httpClient = ChiscoClient();

  @override
  Future<ChiscoResponse> editUserInformation(
      String? location, int? birthday, String? fullName) async {
    ChiscoResponse chiscoResponse = await _httpClient.request(
        type: RequestType.put,
        url: 'user/edit',
        data: {
          'birthday': birthday,
          'location': location,
          'fullName': fullName
        });
    print(chiscoResponse.object.toString());
    return chiscoResponse;
  }
}
