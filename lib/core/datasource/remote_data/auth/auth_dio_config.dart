import 'package:dio/dio.dart';

import '../interceptors/auth_interceptors.dart';
import '../interceptors/logging_Interceptors.dart';

class AuthDioConfig {
  static Dio createDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
        connectTimeout: Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(AuthInterceptors());
    dio.interceptors.add(LoggingInterceptors());
    return dio;
  }
}
