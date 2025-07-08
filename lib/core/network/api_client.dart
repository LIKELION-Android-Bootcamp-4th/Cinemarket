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
        // final accessToken = await TokenStorage.getAccessToken();  // todo: 하드코딩 토큰값 넣기 위한 주석  // 추후에 반드시 해제할 것
        final accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODY5MTUxYjUzZmM4NTdjOGVjYTNhMjciLCJjb21wYW55SWQiOiI2ODY2ZmQyNDViMjMwZjVkYzcwOWJkZjMiLCJpc0FkbWluIjp0cnVlLCJpc1N1cGVyQWRtaW4iOmZhbHNlLCJpYXQiOjE3NTE5ODkyMTYsImV4cCI6MTc1MjA3NTYxNn0.E5podYZML0jZQd6tff8eOAj6WXpS5cdJ27KQe5dY19M';
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
