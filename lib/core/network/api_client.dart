import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:dio/dio.dart';
class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://git.hansul.kr:3003',
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
  ]);
}
