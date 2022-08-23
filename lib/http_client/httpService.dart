import 'dart:io';

import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_source/auth/auth_local_data_source_impl.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RequestType { post, get, put }

final httpClient = ChiscoClient();

class ChiscoClient {
  late final Dio _dio;
  RequestType requestType = RequestType.post;
  AuthLocalDataSourceImpl localDataSourceImpl = AuthLocalDataSourceImpl();

  ChiscoClient() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://chisco.tech/api/",
      connectTimeout: 7000,
      receiveTimeout: 7000,
      sendTimeout: 7000,
      receiveDataWhenStatusError: true,
    ))
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<ChiscoResponse> request(
      {RequestType type = RequestType.post,
      required String url,
      dynamic data}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    try {
      Response response;
      if (type == RequestType.post) {
        response = await _dio.post(
          url,
          data: data,
          options: Options(headers: {
            "x-auth-token": sharedPreferences.getString("access_token")
          }),
        );
      } else if (type == RequestType.put) {
        response = await _dio.put(
          url,
          data: data,
          options: Options(headers: {
            "x-auth-token": sharedPreferences.getString("access_token")
          }),
        );
      } else {
        response = await _dio.get(
          url,
          options: Options(headers: {
            "x-auth-token": sharedPreferences.getString("access_token")
          }),
        );
      }
      return ChiscoResponse(
          status: true, code: response.statusCode, object: response.data);
    } on SocketException {
      return ChiscoResponse(
        status: false,
        code: 406,
        errorMessage: 'اتصال انترنت خود را بررسی کنید!',
      );
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        print("Errorrrrrrrrrr Internettttttt");
        return ChiscoResponse(
            status: false,
            code: 100,
            errorMessage: "اتصال به اینترنت خود را بررسی کنید");
      }

      print(error.message);
      if (error.response!.statusCode == 401) {
        print('Refresh Token is call 401 Error');
        try {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          String? accessToken = sharedPreferences.getString('access_token');
          String? refreshToken = sharedPreferences.getString('refresh_token');
          String? detail = sharedPreferences.getString('detail');

          Response<dynamic> refreshRequest = await _dio.put(
              "user/refresh-token",
              options: Options(headers: {"x-auth-token": accessToken}),
              data: {'refreshToken': refreshToken});

          print('Refresh Token Call');
          print(refreshRequest.data.toString());

          localDataSourceImpl.saveToken(refreshRequest.data['accessToken'],
              refreshRequest.data['refreshToken'], detail!);
          print('Tokens Saved');
          return request(url: url, data: data, type: type);

        } catch (err) {
          print("Error For Refresh Token ${err.toString()}");
          return ChiscoResponse(
              status: false, code: 401, errorMessage: err.toString());
        }

        //return ChiscoResponse(status: false, code: error.response?.statusCode);
      } else {
        return ChiscoResponse(
          status: false,
          code: error.response!.statusCode,
          errorMessage: error.response?.data['message'],
        );
      }
    }
  }

/* Future<ChiscoResponse> get(String url) async {
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
      if(error.type ==DioErrorType.connectTimeout){
        print("Errorrrrrrrrrr Internettttttt");
        return ChiscoResponse(status: false, code: 100,errorMessage: "اتصال به اینترنت خود را بررسی کنید");
      }

      print(error.message);
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
  }*/
}
