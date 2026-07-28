import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';

import '../interceptors/loggingInterceptors.dart';

class NewsDioConfig {
  static Dio createDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
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
