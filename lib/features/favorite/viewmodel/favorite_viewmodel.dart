import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/features/favorite/repository/favorite_repository.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:flutter/foundation.dart';

class FavoriteViewModel extends ChangeNotifier {

  final FavoriteRepository _favoriteRepository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  List<Goods> favoriteGoods = [];
  List<TmdbMovie> favoriteMovies = [];


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

            for (var item in favoriteGoods) {
              }

    } catch (e, stackTrace) {
                      }
  }

  Future<bool> toggleFavorite({required String goodsId,}) async {
    try {
      final bool isSuccesses = await _favoriteRepository.toggleFavorite(goodsId: goodsId);


      return isSuccesses;
    } catch (e, stackTrace) {

      throw(e, stackTrace);
    }
  }


  Future<void> getAllFavoriteMovies() async {

    try {
      favoriteMovies = await _favoriteRepository.getAllFavoriteMovies();
      notifyListeners();

    } catch (e, stackTrace) {
                      }
  }

  Future<bool> toggleMovieFavorite({required String contentId,}) async {
    try {
      final bool isSuccess = await _favoriteRepository.toggleMovieFavorite(contentId: contentId);

      return isSuccess;
    } catch (e, stackTrace) {


      return false;
    }
  }

}