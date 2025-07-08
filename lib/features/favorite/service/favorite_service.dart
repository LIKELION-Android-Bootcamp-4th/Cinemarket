

import 'package:cinemarket/core/network/api_client.dart';
import 'package:dio/dio.dart';

class FavoriteService {
  final Dio _dio = ApiClient.dio;

  Future<bool> toggleFavorite({
    required String goodsId,
}) async {
    try {
      final response = await _dio.post(
        '/api/products/$goodsId/toggle-favorites'
      );

      return response.data['success'] == true;  // bool? 고려

    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message;
      throw Exception('굿즈 찜 실패: $message');
    }
  }

}