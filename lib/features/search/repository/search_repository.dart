import 'package:cinemarket/features/search/model/search_goods_model.dart';
import 'package:cinemarket/features/search/service/search_service.dart';

class SearchRepository {
  final SearchService _searchService;

  SearchRepository({SearchService? searchService})
      : _searchService = searchService ?? SearchService();

  Future<List<SearchItem>> searchMovies(String keyword) async {
    return await _searchService.fetchSearchResults(keyword);
  }
}