import 'package:cinemarket/features/favorite/model/favorite_item.dart';
import 'package:cinemarket/features/favorite/service/favorite_service.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/services/goods_service.dart';

class FavoriteRepository {
  final FavoriteService favoriteService;
  final GoodsService goodsService = GoodsService();

  FavoriteRepository({required this.favoriteService});

  Future<List<FavoriteItem>> getAllFavoriteItems({
    int page = 1,
    int limit = 20,
    String sort = 'createdAt',
    String order = 'desc',
  }) {
    return favoriteService.getAllFavoriteItems(
      page: page,
      limit: limit,
      sort: sort,
      order: order,
    );
  }

  Future<List<Goods>> getAllFavoriteGoods() async {
    List<Goods> favoriteGoods = [];
    List<FavoriteItem> favoriteItems = await getAllFavoriteItems();

    for (final item in favoriteItems) {
      final response = await goodsService.getDetailGoods(
          goodsId: item.favoriteGoods.id);
      Goods goods = response.data;
      favoriteGoods.add(goods);
    };

    return favoriteGoods;
  }

  Future<bool> toggleFavorite({required String goodsId,}) async {
    return await favoriteService.toggleFavorite(goodsId: goodsId);
  }
}