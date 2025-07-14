import 'package:cinemarket/features/search/model/search_goods_model.dart';
import 'package:cinemarket/features/search/model/search_tmdb_model.dart';
import 'package:cinemarket/features/search/repository/search_repository.dart';

import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchRepository _repository;

  SearchViewModel({SearchRepository? repository})
      : _repository = repository ?? SearchRepository();


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SearchTmdbModel> _tmdbResults = [];
  List<SearchTmdbModel> get tmdbResults => _tmdbResults;

  List<SearchItem> _goodsResults = [];
  List<SearchItem> get goodsResults => _goodsResults;

  final Set<int> _failedMovieIds = {};

  int _currentGoodsPage = 1;
  int get currentPage => _currentGoodsPage;
  int _currentMoviePage = 1;
  int get currentMoviePage => _currentMoviePage;

  int _itemPerPage = 6;

  int get totalPages => (_goodsResults.length/ _itemPerPage).ceil().clamp(1, double.infinity).toInt();
  int get movieTotalPages => (_tmdbResults.length / _itemPerPage).ceil().clamp(1, double.infinity).toInt();

  List<SearchItem> get pageGoodsResults {
    final start = (_currentGoodsPage - 1) * _itemPerPage;
    final end = (_currentGoodsPage * _itemPerPage).clamp(0, _goodsResults.length);
    return _goodsResults.sublist(start, end);
  }

  List <SearchTmdbModel> get pageMovieResults {
    final start = (_currentMoviePage - 1) * _itemPerPage;
    final end = (_currentMoviePage * _itemPerPage).clamp(0, _tmdbResults.length);
    return _tmdbResults.sublist(start, end);
  }
  void goToGoodsPage(int page) {
    _currentGoodsPage = page.clamp(1, totalPages);
    notifyListeners();
  }

  void goToMoviePage(int page) {
    _currentMoviePage = page.clamp(1, movieTotalPages);
    notifyListeners();
  }

  void reset() {
    _goodsResults = [];
    _tmdbResults = [];
    _currentGoodsPage = 1;
    _currentMoviePage = 1;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> search(String keyword) async {
    _isLoading = true;
    notifyListeners();

    List<SearchItem> fromContentId = [];
    List<SearchItem> fromKeyword = [];

    try {
      //TMDB 영화 검색
      _tmdbResults = await _repository.searchMovies(keyword);
    } catch (e) {
      print('TMDB 검색 실패: $e');
      _tmdbResults = [];
    }

    try {
      final filtered = _tmdbResults
          .where((m) => m.id != 0 && !_failedMovieIds.contains(m.id))
          .toList();

      //영화 ID 10개씩 묶어서 테스트 (요청량 조절)
      for (final movie in filtered.take(10)) {
        try {
          final goods = await _repository.searchMovieByContentId(movie.id);

          // 실제 굿즈가 있을 때만 추가
          if (goods.isNotEmpty) {
            fromContentId.addAll(goods);
          } else {
            print('굿즈 없음 (movie.id: ${movie.id})');
          }
        } catch (e) {
          print('굿즈 검색 실패 (movie.id: ${movie.id}) -> 무시');
          _failedMovieIds.add(movie.id);
        }
      }
    } catch (e) {
      print('전체 굿즈 처리 실패: $e');
    }

    try {
      fromKeyword = await _repository.searchGoodsByKeyword(keyword);
    } catch (e) {
      print('키워드 검색 실패 : $e');
    }

    final allGoods = {
      for (var item in [...fromContentId, ...fromKeyword]) item.id: item
    }.values.toList();

    _goodsResults = allGoods;
    _isLoading = false;
    notifyListeners();
  }
}