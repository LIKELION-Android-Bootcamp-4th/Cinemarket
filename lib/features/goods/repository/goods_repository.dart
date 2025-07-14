import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/model/goods_review.dart';
import 'package:cinemarket/features/goods/services/goods_service.dart';
import 'package:cinemarket/features/movies/model/tmdb_movie_detail.dart';
import 'package:cinemarket/features/movies/service/movies_service.dart';

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

  Future<List<GoodsReview>> getGoodsReviews({
    required String goodsId,
}) async {
    final response = await _goodsService.getGoodsReviews(goodsId: goodsId);

    final reviews = response.data['data']['items'] as List<dynamic>;

    return reviews.map((review) => GoodsReview.fromJson(review)).toList();
  }

  Future<String> getMovieTitleFromGoodsId({ required String goodsId}) async {
    final response = await _goodsService.getMovieTitleFromGoodsId(goodsId: goodsId);

    final items = response.data['data']['items'];

    if (items is List && items.isNotEmpty) {
      return items.first['title'];
    }

    return '';
  }
  Future<String> tempGetMovieTitleFromGoodsId({ required String goodsId}) async {  // 서버 api에서 title 제공 시 삭제 예정
    final response = await _goodsService.getMovieTitleFromGoodsId(goodsId: goodsId);

    final items = response.data['data']['items'];
    final int contentId = items.first['contentId'];

    final TmdbMovieDetail movieDetail = await MoviesService().fetchMovieDetail(contentId);

    return movieDetail.title;
  }
}
