import 'package:cinemarket/core/network/api_client.dart';
import 'package:dio/dio.dart';

class GoodsRecommendedService {
  final _dio = ApiClient.dio;

  // 영화 관련 굿즈 상품 조회
  Future<Response> fetchMovieProducts(String contentId) async {
    try {
      final response = await _dio.get('/api/content-product/products/$contentId');

      return response;
    } catch (e) {
      throw Exception('영화 연관 굿즈 불러오기 실패: $e');
    }
  }

  //상품 이름으로 contentId 찾기.
  Future<String?> fetchContentIdByProductId(String productId) async {
    try {
      final response = await _dio.get('/api/content-product/contents/$productId');
      final items = response.data['data']['items'] as List<dynamic>;
      if (items.isNotEmpty) {
        final contentId = items[0]['contentId'] as int?;
        return contentId?.toString();
      }
      return null;
    } catch (e) {
      print('Error fetching contentId: $e');
      return null;
    }
  }
}