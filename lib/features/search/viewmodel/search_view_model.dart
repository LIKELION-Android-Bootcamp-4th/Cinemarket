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



  Future<void> search(String keyword) async {
    _isLoading = true;
    notifyListeners();

    List<SearchItem> fromContentId = [];
    List<SearchItem> fromKeyword = [];

    try {
      //영화 검색
      _tmdbResults = await _repository.searchMovies(keyword);
    } catch (e) {
      print('TMDB 검색 실패: $e');
      _tmdbResults = [];
    }

    try {
      //영화ID로  굿즈 검색
      for (final movie in _tmdbResults) {
        if (movie.id ==0) {
          print('없는 movie id');
          continue;
        }
        try {
          final goods = await _repository.searchMovieByContentId(movie.id);
          fromContentId.addAll(goods);
        } catch (e) {
          print('굿즈 검색 실패 (movie.id: ${movie.id}) -> 무시하고 다음');
        }
      }
    } catch (e) {
      print(' 전체 굿즈 처리 실패: $e');
    }

    try {
      //키워드 기반 검색
      fromKeyword = await _repository.searchGoodsByKeyword(keyword);
    } catch (e) {
      print('키워드 검색 실패 : $e');
    }

    final allGods = {
      for (var item in [...fromContentId, ...fromKeyword]) item.id : item
    }.values.toList();

    _goodsResults = allGods;
    _isLoading = false;
    notifyListeners();
  }
}