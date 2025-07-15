import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/features/favorite/repository/favorite_repository.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class FavoriteViewModel extends ChangeNotifier {

  final FavoriteRepository _favoriteRepository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  List<Goods> favoriteGoods = [];
  List<TmdbMovie> favoriteMovies = [];

  final Logger logger = Logger();

  FavoriteViewModel({FavoriteRepository? favoriteRepository}) : _favoriteRepository = FavoriteRepository();

  Future<void> getAllFavorites() async {
    _isLoading = true;
    notifyListeners();

    final token = await TokenStorage.getAccessToken();
    _isLogin = token != null;

    await Future.wait([
      getAllFavoriteGoods(),
      getAllFavoriteMovies(),
    ]);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAllFavoriteGoods({
    int page = 1,
    int limit = 20,
    String sort = 'createdAt',
    String order = 'desc',
  }) async {

    try {
      favoriteGoods = await _favoriteRepository.getAllFavoriteGoods();
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

  Future<bool> toggleFavorite({required String goodsId,}) async {
    try {
      final bool isSuccesses = await _favoriteRepository.toggleFavorite(goodsId: goodsId);

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


  Future<void> getAllFavoriteMovies() async {

    try {
      favoriteMovies = await _favoriteRepository.getAllFavoriteMovies();
      notifyListeners();

      logger.i('😎😎😎 영화 찜 목록 조회');
      for (var movie in favoriteMovies) {
        logger.d('favoriteGoods\n'
            'id: ${movie.id}\n'
            'title: ${movie.title}\n'
        'isFavorite: ${movie.isFavorite}');
      }

    } catch (e, stackTrace) {
      logger.i('😂😂😂 영화 찜 목록 조회 실패');
      logger.d(e);
      logger.d(stackTrace);
    }
  }

  Future<bool> toggleMovieFavorite({required String contentId,}) async {
    try {
      final bool isSuccess = await _favoriteRepository.toggleMovieFavorite(contentId: contentId);

      Logger().i('😍😍😍');
      Logger().i('isSuccess : $isSuccess');

      return isSuccess;
    } catch (e, stackTrace) {

      Logger().e('😂😂😂 err');
      Logger().e('$e');
      Logger().e('$stackTrace');

      return false;
    }
  }

}