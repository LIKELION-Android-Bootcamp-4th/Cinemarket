import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/services/goods_recommended_service.dart';

class GoodsRecommendedRepository {
  final GoodsRecommendedService _service = GoodsRecommendedService();

  Future<List<Goods>> getRecommendedGoods({
    required String contentId,
    required String excludeProductId,
  }) async {
    try {
      final response = await _service.fetchMovieProducts(contentId);
      final data = response.data;

      final rawItems = data['data']['items'] as List<dynamic>? ?? [];

      final goodsList = rawItems
          .map((item) => Goods.fromJson(Map<String, dynamic>.from(item)))
          .where((g) => g.id != excludeProductId)
          .toList();

      return goodsList;
    } catch (e) {
      throw Exception('추천 굿즈 조회 실패: $e');
    }
  }

  Future<String?> getContentIdByProductId(String productId) async {
    return await _service.fetchContentIdByProductId(productId);
  }
}
