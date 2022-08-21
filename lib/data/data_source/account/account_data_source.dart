import 'package:chisco/data/data_class/ChiscoResponse.dart';

abstract class AccountDataSource{
  Future<ChiscoResponse> editUserInformation(String? location,int? birthday,String? fullName);

}