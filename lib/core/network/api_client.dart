import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://git.hansul.kr:3000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
        'X-Company-Code': '6866fd245b230f5dc709bdf3',
      },
    )
  )..interceptors.addAll([
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await TokenStorage.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
    ),
    // PrettyDioLogger(
    //   requestHeader: true,
    //   requestBody: true,
    //   responseBody: true,
    //   responseHeader: false,
    //   error: true,
    //   compact: true,
    //   maxWidth: 120,
    // ),
  ]);
}
