import 'package:dio/dio.dart';

import 'dio_config.dart';

class DioEx {
  static final dio = DioConfig.createDio();

  static Future<void> exampleGetRequest() async {
      await dio.get('products');
  }

  static Future<void> exampleGetRequestWithQueryParameter() async {
     await dio.get(
      "products/search",
      queryParameters: {"q": "phone"},
    );
  }

  static Future<void> examplePostRequest() async {
     await dio.post(
      "products/add",
      data: {"title": "BMW Pencil"},
    );
  }

  static Future<void> examplePutRequest() async {
     await dio.put("products/1", data: {"title": "iPhone Galaxy +1"},);

  }

  static Future<void> exampleDeleteRequest() async {
    final response = await dio.delete("products/1");
  }
  static Future<void> exampleErrorRequest() async {
    try {
    dio.post("lsdfnlsdfhnldkfshkldfs");
    } on DioException catch (e) {

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.badCertificate:
        case DioExceptionType.badResponse:
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
        case DioExceptionType.transformTimeout:
      }
    }
  }
}
