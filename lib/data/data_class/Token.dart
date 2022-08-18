import 'dart:ffi';

abstract class TokenBase{

  String? token;

  String? refreshToken;

  String? detail;

  void update(String? token,String? refreshToken,String? detail){

    this.token = token;
    this.refreshToken =refreshToken;
    this.detail = detail;

  }



}