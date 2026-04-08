import 'package:dio/dio.dart';

class HttpClient {
  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://viacep.com.br/ws/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );
  }
}
