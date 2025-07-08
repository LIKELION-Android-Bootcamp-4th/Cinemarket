

import 'package:cinemarket/features/favorite/repository/favorite_repository.dart';
import 'package:flutter/foundation.dart';

class FavoriteViewModel extends ChangeNotifier {
  final FavoriteRepository favoriteRepository;

  FavoriteViewModel({required this.favoriteRepository});

  Future<bool> toggleFavorite({required String goodsId,}) async {
    try {
      final bool isSuccesses = await favoriteRepository.toggleFavorite(goodsId: goodsId);

      debugPrint('😍😍😍');
      debugPrint('isSuccess : $isSuccesses');

      return isSuccesses;  // todo: 로그 출력을 위해 바로 리턴하지 않고 변수 생성  // 변수 삭제 후 바로 리턴할 것
    } catch (e, stackTrace) {
      debugPrint('😂😂😂 err');
      debugPrint('$e');
      debugPrint('$stackTrace');

      throw(e, stackTrace);
    }
  }
}