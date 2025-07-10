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