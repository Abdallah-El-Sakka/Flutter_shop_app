import 'package:dio/dio.dart';

class DioHelper
{
  static late Dio dio = Dio();

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers:
        {
          'lang' : 'en'
        }
      )
    );
  }

  static Future<Response> getData({
    String? token,
    required String url,
    query,
  }) async
  {

    dio.options.headers =
    {
      'Authorization' : token??'',
      'Content-Type' : 'application/json',
      'lang' : 'en'
    };

    return await dio.get(
        url,
        queryParameters: query
    );
  }

  static Future<Response> postData({
    token,
    required String url,
    query,
    required Map<String,dynamic> data
  }) async
  {

    dio.options.headers =
    {
      'Authorization' : token,
      'lang' : 'en',
      'content-type' : 'application/json'
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    token,
    required String url,
    query,
    required Map<String,dynamic> data
  }) async
  {

    dio.options.headers =
    {
      'Authorization' : token,
      'lang' : 'en',
      'content-type' : 'application/json'
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

}