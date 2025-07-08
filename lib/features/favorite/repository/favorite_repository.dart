

import 'package:cinemarket/features/favorite/model/favorite_item.dart';
import 'package:cinemarket/features/favorite/service/favorite_service.dart';

class FavoriteRepository {
  final FavoriteService favoriteService;

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
}