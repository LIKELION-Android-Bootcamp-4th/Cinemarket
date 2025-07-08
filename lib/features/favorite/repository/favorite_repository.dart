

import 'package:cinemarket/features/favorite/service/favorite_service.dart';

class FavoriteRepository {
  final FavoriteService favoriteService;

  FavoriteRepository({required this.favoriteService});

  Future<bool> toggleFavorite({required String goodsId,}) async {
    return await favoriteService.toggleFavorite(goodsId: goodsId);
  }
}