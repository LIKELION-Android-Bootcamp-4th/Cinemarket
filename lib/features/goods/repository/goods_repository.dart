import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/services/goods_service.dart';

class GoodsAllRepository {
  final GoodsAllService _goodsAllService;

  GoodsAllRepository({GoodsAllService? goodsAllService})
    : _goodsAllService = goodsAllService ?? GoodsAllService();

  Future<List<Goods>> getAllGoodsList({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? category,
    String? search,
    String? sortBy,
    String sortOrder = 'desc',
  }) async {
    final result = await _goodsAllService.getAllGoods(
      page: page,
      limit: limit,
      categoryId: categoryId,
      category: category,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );

    return result.items;
  }
}
