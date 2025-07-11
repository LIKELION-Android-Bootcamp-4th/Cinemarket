import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/services/goods_recommended_service.dart';

class GoodsRecommendedRepository {
  final GoodsRecommendedService _service = GoodsRecommendedService();

  Future<ListResponse<Goods>> getRecommendedGoods({
    required String contentId,
    required String excludeProductId,
  }) async {
    try {
      final response = await _service.fetchMovieProducts(contentId);

      final parsed = ListResponse<Goods>.fromJson(
        response.data,
            (json) => Goods.fromJson(json as Map<String, dynamic>),
      );

      // 현재 상품 제외
      final filtered = parsed.items.where((g) => g.id != excludeProductId).toList();

      return ListResponse<Goods>(
        success: parsed.success,
        message: parsed.message,
        items: filtered,
        pagination: parsed.pagination,
        timestamp: parsed.timestamp,
      );
    } catch (e) {
      throw Exception('추천 굿즈 조회 실패: $e');
    }
  }

  Future<String?> getContentIdByProductId(String productId) async {
    return await _service.fetchContentIdByProductId(productId);
  }
}
