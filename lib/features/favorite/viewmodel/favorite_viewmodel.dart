import 'package:cinemarket/features/favorite/model/favorite_item.dart';
import 'package:cinemarket/features/favorite/repository/favorite_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class FavoriteViewModel extends ChangeNotifier {
  final FavoriteRepository favoriteRepository;

  List<FavoriteItem> favoriteItems = [];
  final Logger logger = Logger();

  FavoriteViewModel({required this.favoriteRepository});

  Future<void> getAllFavoriteItems({
    int page = 1,
    int limit = 20,
    String sort = 'createdAt',
    String order = 'desc',
  }) async {
    try {
      favoriteItems = await favoriteRepository.getAllFavoriteItems(
        page: page,
        limit: limit,
        sort: sort,
        order: order,
      );
      notifyListeners();

      logger.i('굿즈 찜 목록 조회');
      favoriteItems.forEach( (item) {
        logger.d('favoriteItem ${item.favoriteGoods}');
      });

    } catch (e, stackTrace) {
      logger.i('😂😂😂 err');
      logger.d(e);
      logger.d(stackTrace);
    }
  }

}