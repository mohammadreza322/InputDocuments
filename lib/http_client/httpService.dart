import 'dart:convert';
import 'dart:io';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_source/auth/auth_local_data_source_impl.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

///this class is for connecting to Server

final httpClient = ChiscoClient();

/// we have 3 type of request post get put in our app
enum RequestType { post, get, put }

class ChiscoClient {
  late final Dio _dio;
  RequestType requestType = RequestType.post;
  AuthLocalDataSourceImpl localDataSourceImpl = AuthLocalDataSourceImpl();

  ChiscoClient() {
    ///we create an instance of [dio] for sending request
    ///we contain Options here
    ///if after 10 minuets cant connect we got Socket Error
    _dio = Dio(BaseOptions(
      baseUrl: "https://chisco.tech/api/",
      connectTimeout: 10000,
      receiveTimeout: 7000,
      sendTimeout: 7000,
      receiveDataWhenStatusError: true,
    ))
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

    ///we add interceptors get Logs we we send requests
  }

  ///request method :

  /// request method has 3 params
  ///[type] is contain the Request Type we have 3 different type of request [POST] ,[ GET] , [PUT]
  ///[url] is a path url
  ///[data] is json string this we must send it to server

  Future<ChiscoResponse> request(
      {RequestType type = RequestType.post,
      required String url,
      dynamic data}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    try {
      ///x-auth-token is send in all requests
      Response response;
      if (type == RequestType.post) {
        ///post Request
        response = await _dio.post(
          url,
          data: data,
          options: Options(headers: {
            "x-auth-token": sharedPreferences.getString("access_token")
          }),
        );
      } else if (type == RequestType.put) {
        ///put Request
        response = await _dio.put(
          url,
          data: data,
          options: Options(headers: {
            "x-auth-token": sharedPreferences.getString("access_token")
          }),
        );
      } else {
        ///get Request
        response = await _dio.get(
          url,
          options: Options(headers: {
            "x-auth-token": sharedPreferences.getString("access_token")
          }),
        );
      }

      Map<String, dynamic> responseData = Map.from(response.data);

      if (responseData['refreshToken'] != null) {
        return refreshToken(url: url, data: data, type: type);
      }

      return ChiscoResponse(
          status: true, code: response.statusCode, object: response.data);
    } on DioError catch (error) {
      ///here we got error if we cant connect to server
      ///ConnectionTimeOut if we cant connect to server after 10 second
      if (error.type == DioErrorType.connectTimeout) {
        print('Error HTTP Connection.......');
        return ChiscoResponse(
            status: false,
            code: 404,
            errorMessage: "اتصال به اینترنت خود را بررسی کنید");
      } else if (error.type == DioErrorType.other) {
        ///if error type is [other] its means that our network is off
        ///no internet , wifi error , VPN is on,
        return ChiscoResponse(
            status: false,
            code: 404,
            errorMessage: 'اتصال به اینترنت خود را بررسی کنید!');
      }

      ///if response status code is 401 its means our token is Expire and we have to refresh the token
      if (error.response!.statusCode == 401) {
        return refreshToken(url: url, type: type, data: data);
      } else {
        return ChiscoResponse(
          status: false,
          code: error.response!.statusCode,
          errorMessage: error.response?.data['message'],
        );
      }
    } catch (e) {
      // if ((e as SocketException).message ==
      //     "Failed host lookup: 'chisco.tech' (OS Error: No address associated with hostname, errno = 7)")
      //   print('***** Exception Caught *****');
      print(e);
      print("**************************");
      print("ok123");
      return ChiscoResponse(
          status: false,
          code: 401,
          errorMessage: 'خطا در برقراری ارتباط!',
          object: {});
    }
  }

  refreshToken(
      {RequestType type = RequestType.post,
      required String url,
      dynamic data}) async {
    try {
      print("called refresh token");
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? accessToken = sharedPreferences.getString('access_token');
      String? refreshToken = sharedPreferences.getString('refresh_token');
      // String? detail = sharedPreferences.getString('detail');

      ///here we send request for refresh token
      Response refreshRequest = await _dio.put("user/refresh-token",
          options: Options(headers: {"x-auth-token": accessToken}),
          data: {'refreshToken': refreshToken});

      ///after receive Response we save it to SharePreferences
      ///and then we call old request again
      await localDataSourceImpl.saveToken(refreshRequest.data['accessToken'],
          refreshRequest.data['refreshToken'], null);

      return await request(url: url, data: data, type: type);
    } catch (err) {
      return ChiscoResponse(
          status: false, code: 401, errorMessage: 'خطا در برقراری ارتباط!');
    }
  }
}
