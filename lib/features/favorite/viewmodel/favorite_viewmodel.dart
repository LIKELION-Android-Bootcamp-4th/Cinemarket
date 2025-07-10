import 'package:cinemarket/features/favorite/repository/favorite_repository.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class FavoriteViewModel extends ChangeNotifier {
  final FavoriteRepository favoriteRepository;

  List<Goods> favoriteGoods = [];
  final Logger logger = Logger();

  FavoriteViewModel({required this.favoriteRepository});

  Future<void> getAllFavoriteGoods({
    int page = 1,
    int limit = 20,
    String sort = 'createdAt',
    String order = 'desc',
  }) async {
    try {
      favoriteGoods = await favoriteRepository.getAllFavoriteGoods();
      notifyListeners();

      logger.i('굿즈 찜 목록 조회');
      for (var item in favoriteGoods) {
        logger.d('favoriteGoods $item');
      }

    } catch (e, stackTrace) {
      logger.i('😂😂😂 err');
      logger.d(e);
      logger.d(stackTrace);
    }
  }

}