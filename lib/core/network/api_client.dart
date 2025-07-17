import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
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
        onError: (error, handler) async {
          final response = error.response;

          if (response?.statusCode == 403 &&
              (response?.data['message'] == 'Invalid or expired token')){
            final refreshToken = await TokenStorage.getRefreshToken();

            final refreshResponse = await dio.post('/api/auth/refresh', data: {
              'refreshToken': refreshToken,
            });

            if (refreshResponse.statusCode == 200) {
              final newAccessToken = refreshResponse.data['data']['accessToken'];
              await TokenStorage.saveAccessToken(newAccessToken);

              final retryRequest = error.requestOptions;

              final updatedHeaders = Map<String, dynamic>.from(retryRequest.headers);
              updatedHeaders['Authorization'] = 'Bearer $newAccessToken';

              final retryResponse = await dio.request(
                retryRequest.path,
                data: retryRequest.data,
                queryParameters: retryRequest.queryParameters,
                options: Options(
                  method: retryRequest.method,
                  headers: updatedHeaders,
                  extra: {'isRetry': true},
                ),
              );

              return handler.resolve(retryResponse);
            } else {
              TokenStorage.clearTokens();
              handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  error: Exception(),
                ),
              );
              return;
            }
          }
          return handler.next(error);
        }
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
