import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/services/goods_service.dart';

class GoodsRepository {
  final GoodsService _goodsService;

  GoodsRepository({GoodsService? goodsAllService})
    : _goodsService = goodsAllService ?? GoodsService();

  Future<List<Goods>> getAllGoodsList({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? category,
    String? search,
    String? sortBy,
    String sortOrder = 'desc',
  }) async {
    final result = await _goodsService.getAllGoods(
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

  Future<Goods> getDetailGoods({
    required String goodsId,
  }) async {
    final result = await _goodsService.getDetailGoods(goodsId: goodsId,);

    return result.data;
  }
}
