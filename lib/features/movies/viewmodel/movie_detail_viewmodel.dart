import 'package:cinemarket/features/home/model/best_goods.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/features/movies/model/tmdb_movie_detail.dart';
import 'package:cinemarket/features/movies/model/cast_member.dart';
import 'package:cinemarket/features/movies/repository/movie_detail_repository.dart';

class MovieDetailViewModel extends ChangeNotifier {
  final MovieDetailRepository _repository = MovieDetailRepository();

  TmdbMovieDetail? _movieDetail;
  List<BestGoods> _goodsList = [];
  List<CastMember> _castList = [];

  bool _isMovieLoading = false;
  bool _isGoodsLoading = false;

  String? _error;
  bool? _success;
  String? _message;

  TmdbMovieDetail? get movieDetail => _movieDetail;
  List<CastMember> get castList => _castList;
  List<BestGoods> get goodsList => _goodsList;

  bool get isLoading => _isMovieLoading || _isGoodsLoading;

  String? get error => _error;
  bool? get success => _success;
  String? get message => _message;

  Future<void> loadMovieDetail(int movieId) async {
    _isMovieLoading = true;
    _error = null;
    notifyListeners();

    try {
      _movieDetail = await _repository.getMovieDetail(movieId);
      _castList = await _repository.getMovieCredits(movieId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isMovieLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadRecommendedGoods(String contentId) async {
    _isGoodsLoading = true;
    _error = null;
    notifyListeners();

    try {
      final goodsList = await _repository.fetchMovieProducts(contentId);
      _goodsList = goodsList;
      _success = true;
    } catch (e) {
      _goodsList = [];
      _error = e.toString();
      _success = false;
    } finally {
      _isGoodsLoading = false;
      notifyListeners();
    }
  }

}

