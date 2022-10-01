import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/EditUserResponse.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';
import 'package:chisco/data/data_source/account/account_remote_data_source.dart';

abstract class AccountRepository {
  Future<ChiscoResponse> editUserInformation(
      String? location, int? birthday, String? fullName);
}

class AccountRepositoryImpl extends AccountRepository {
  final AccountRemoteDataSource _accountRemoteDataSource =
      AccountRemoteDataSource();

  @override
  Future<ChiscoResponse> editUserInformation(
      String? location, int? birthday, String? fullName) async {

    ChiscoResponse response = await _accountRemoteDataSource.editUserInformation(location, birthday, fullName);
    if (response.status) {
      MessageResponse messageResponse =
          MessageResponse.fromJson(response.object);
      EditUserResponse editUserResponse = EditUserResponse.fromJson(response.object);
      ChiscoResponse chiscoResponse =
          ChiscoResponse(status: true, code: 408, object: editUserResponse);
      return chiscoResponse;
    } else {
      return response;
    }
  }
}
