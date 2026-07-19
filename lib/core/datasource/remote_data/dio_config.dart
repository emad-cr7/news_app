import 'package:dio/dio.dart';

import 'interceptors/loggingInterceptors.dart';

class DioConfig {
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
    dio.interceptors.add(LoggingInterceptors());
    return dio;
  }
}
