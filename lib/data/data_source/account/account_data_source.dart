import 'package:chisco/data/data_class/ChiscoResponse.dart';



abstract class AccountDataSource{
  ///this request is for editing user information and its use in ProfileScreen after pressing edit btn.
  ///implementation of this class is in AccountRemoteDataClass
  Future<ChiscoResponse> editUserInformation(String? location,int? birthday,String? fullName);



}