import 'package:dio/dio.dart';

class DioClient {
  static late Dio dio;
  static late Response response;

  static init() {
    dio = Dio();
  }

  static Future<Response> getData(String url) async {
    return response = await dio.get(url);
  }
}
