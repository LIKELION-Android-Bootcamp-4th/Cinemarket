import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/features/goods/model/goods_response.dart';
import 'package:dio/dio.dart';

class GoodsService {
  final Dio _dio = ApiClient.dio;

  Future<GoodsAllResponse> getAllGoods({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? category,
    String? search,
    String? sortBy,
    String sortOrder = 'desc',
}) async {
    try {
      final response = await _dio.get(
        '/api/products',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (categoryId != null) 'categoryId': categoryId,
          if (category != null) 'category': category,
          if (search != null) 'search': search,
          if (sortBy != null) 'sortBy': sortBy,
          'sortOrder': sortOrder,
        },
      );

      return GoodsAllResponse.fromJson(response.data);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message;
      throw Exception('상품 조회 실패: $message');
    }
  }
}
