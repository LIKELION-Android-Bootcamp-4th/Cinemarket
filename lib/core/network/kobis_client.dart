import 'package:dio/dio.dart';

class KobisClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.kobis.or.kr/kobisopenapi/webservice/rest',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
}
