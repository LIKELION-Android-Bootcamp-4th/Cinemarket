import 'package:cinemarket/features/search/model/search_goods_model.dart';
import 'package:cinemarket/features/search/model/search_tmdb_model.dart';
import 'package:cinemarket/features/search/service/search_service.dart';

class SearchRepository {
  final SearchService _searchService;


  SearchRepository({SearchService? searchService})
      : _searchService = searchService ?? SearchService();


  //tmdb 영화 검색
  Future<List<SearchTmdbModel>> searchMovies(String keyword) async {
    return _searchService.searchMovies(keyword);
  }

  //굿즈 직접 검색
  Future<List<SearchItem>> searchGoodsByKeyword(String keyword) {
    return _searchService.fetchGoodsByKeyword(keyword);
  }

  //영화ID로 굿즈 검색
  Future<List<SearchItem>> searchMovieByContentId(int contentId) {
    return _searchService.fetchMovieByContentId(contentId);
  }
}