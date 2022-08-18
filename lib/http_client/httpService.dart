import 'dart:io';

import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final httpClient = ChiscoClient();
class ChiscoClient {
  late final Dio _dio;

  ChiscoClient()  {
    _dio = Dio(BaseOptions(
      baseUrl: "https://chisco.tech/api/",
      receiveDataWhenStatusError: true,
    ))
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<ChiscoResponse> get(String url) async {
    final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    try {
      Response response = await _dio.get(url,options:Options(
          headers: {"x-auth-token":sharedPreferences.getString("access_token")
          }
      ),);
      //print("Print From Http Service : ${response.data.toString()}");
      return ChiscoResponse(status: true, code: response.statusCode, object: response.data);
    } on SocketException {
      return ChiscoResponse(
        status: false,
        code: 406,
        errorMessage: 'اتصال انترنت خود را بررسی کنید!',);
    } on DioError catch (error) {
      if (error.response!.statusCode == 401) {
        return ChiscoResponse(status: false, code:error.response?.statusCode);
      } else {
        return ChiscoResponse(
            status: false,
            code: error.response!.statusCode,
            errorMessage: error.response?.data['message'],);
      }
    }

  }

  Future<ChiscoResponse> put({required String url,required dynamic data}) async{
    final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    try{
      Response response = await _dio.put(url,data: data,options: Options(
          headers: {"x-auth-token":sharedPreferences.getString("access_token")
          }
      ),);
      print("Response :${response.data.toString()}");
      return ChiscoResponse(status: true, code: response.statusCode,object: response.data);
    }on SocketException{
      return ChiscoResponse(status: false, code:408,errorMessage: 'اتصال به اینترنت خود را بررسی کنید!');

    }on DioError catch (error){
      if (error.response!.statusCode == 401) {
        return ChiscoResponse(status: false, code:error.response?.statusCode);
      } else {
        print("Response :${error.response?.data.toString()}");

        return ChiscoResponse(
            status: false,
            code: error.response!.statusCode,
            errorMessage: error.response?.data['message'],
            object: error.response?.data);
      }
    }
  }

  Future<ChiscoResponse> post({required String url, required dynamic data}) async {
    final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    try {
      Response response = await _dio.post(url, data: data,options:Options(
        headers: {"x-auth-token":sharedPreferences.getString("access_token")
        }
      ),);
      print("Response :${response.data.toString()}");

      return ChiscoResponse(status: true, code: response.statusCode, object: response.data);

    }on SocketException{
      return ChiscoResponse(status: false, code:408,errorMessage: 'اتصال به اینترنت خود را بررسی کنید!');
    } on DioError catch (error) {
      if (error.response!.statusCode == 401) {
        return ChiscoResponse(status: false, code:error.response?.statusCode);
      } else {
        print("Error :${error.response?.data.toString()}");
        return ChiscoResponse(
            status: false,
            code: error.response!.statusCode,
            errorMessage: error.response?.data['message'],
            object: error.response?.data);
      }
    }
  }
}
