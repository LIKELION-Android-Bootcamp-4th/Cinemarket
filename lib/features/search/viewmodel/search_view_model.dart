import 'package:cinemarket/features/search/model/search_goods_model.dart';
import 'package:cinemarket/features/search/repository/search_repository.dart';
import 'package:cinemarket/features/search/service/search_goods_service.dart';
import 'package:cinemarket/features/search/service/search_tmdb_service.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchTmdbService _searchTmdbService;

  final SearchGoodsService _searchGoodsService;

  SearchViewModel({
    SearchTmdbService? searchTmdbService,
    SearchGoodsService? searchGoodsService
  })
      :
        _searchTmdbService = searchTmdbService ?? SearchTmdbService(),
        _searchGoodsService = searchGoodsService ?? SearchGoodsService();


  bool _isLoading = false;
  List<SearchItem> _results = [];
  List<SearchItem> get results => _results;

  bool get isLoading => _isLoading;

  List<SearchMovie> _tmdbResults = [];
  List<SearchMovie> get tmdbResults => _tmdbResults;

  Future<void> search(String keyword) async {
    _isLoading = true;
    notifyListeners();

    List<SearchMovie> tmdbMovies = [];

    try {
      tmdbMovies = await _searchTmdbService.searchMovies(keyword);
      _tmdbResults = tmdbMovies;
      print('TMDB 검색 결과: ${tmdbMovies.length}개');
    } catch (e) {
      print('TMDB API 실패: $e');
      _tmdbResults = [];
    }

    try {
      List<SearchItem> allGoods = [];
      for (final movie in tmdbMovies) {
        try {
          final goods = await _searchGoodsService.fetchGoodsByContentId(
              movie.id);
          print('🛒 ${movie.title} 굿즈 ${goods.length}개');
          allGoods.addAll(goods);
        } catch (e) {
          print(' 굿즈 실패 (movieId: ${movie.id}): $e');
        }
      }
      _results = allGoods;
    } catch (e) {
      print(' 전체 굿즈 처리 실패: $e');
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}