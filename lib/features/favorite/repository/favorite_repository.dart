import 'package:cinemarket/features/favorite/model/favorite_item.dart';
import 'package:cinemarket/features/favorite/service/favorite_service.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/services/goods_service.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/movies/service/movies_service.dart';
import 'package:logger/logger.dart';

class FavoriteRepository {
  final FavoriteService _favoriteService;
  final GoodsService goodsService = GoodsService();
  final MoviesService _moviesService = MoviesService();

  // FavoriteRepository({required this.favoriteService});
  FavoriteRepository({FavoriteService? favoriteService})
      : _favoriteService = favoriteService ?? FavoriteService();

  Future<List<FavoriteItem>> getAllFavoriteItems({
    int page = 1,
    int limit = 20,
    String sort = 'createdAt',
    String order = 'desc',
  }) {
    return _favoriteService.getAllFavoriteItems(
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
        goodsId: item.favoriteGoods.id,
      );
      Goods goods = response.data;
      favoriteGoods.add(goods);
    }
    ;

    return favoriteGoods;
  }

  Future<bool> toggleFavorite({required String goodsId}) async {
    return await _favoriteService.toggleFavorite(goodsId: goodsId);
  }

  Future<bool> toggleMovieFavorite({required String contentId}) async {
    final response = await _moviesService.fetchMovieProducts(contentId);
    Logger().d('${response.data['data']['id']}');
    final contentProductId = response.data['data']['id'];

    return _favoriteService.toggleMovieFavorite(
      contentProductId: contentProductId,
    );
  }

  Future<List<TmdbMovie>> getAllFavoriteMovies() async {
    final List<int> tmdbIds = await _favoriteService.getAllFavoriteMovies();

    final List<TmdbMovie> movies = await Future.wait(
      tmdbIds.map((movieId) async {
        final response = await _moviesService.fetchMovieDetail(movieId);
        return TmdbMovie(
          id: movieId,
          title: response.title,
          overview: 'overview',
          posterPath: response.posterPath,
          releaseDate: 'releaseDate',
          voteAverage: 0,
          popularity: 0,
        );
      }).toList(),
    );

    return movies;
  }
}
