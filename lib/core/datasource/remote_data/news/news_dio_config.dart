import 'package:dio/dio.dart';
import '../interceptors/api_key_interceptor.dart';
import '../interceptors/logging_Interceptors.dart';
import 'news_api_config.dart';

class NewsDioConfig {
  static Dio createDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: NewsApiConfig.baseUrl,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
        connectTimeout: Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(ApiKeyInterceptor());
    dio.interceptors.add(LoggingInterceptors());
    return dio;
  }
}
