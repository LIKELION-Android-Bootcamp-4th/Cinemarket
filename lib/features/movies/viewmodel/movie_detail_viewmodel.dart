import 'package:flutter/material.dart';
import 'package:cinemarket/features/movies/model/tmdb_movie_detail.dart';
import 'package:cinemarket/features/movies/model/cast_member.dart';
import 'package:cinemarket/features/movies/repository/movie_detail_repository.dart';

class MovieDetailViewModel extends ChangeNotifier {
  final MovieDetailRepository _repository = MovieDetailRepository();

  TmdbMovieDetail? _movieDetail;
  List<CastMember> _castList = [];
  bool _isLoading = false;
  String? _error;

  TmdbMovieDetail? get movieDetail => _movieDetail;
  List<CastMember> get castList => _castList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadMovieDetail(int movieId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _movieDetail = await _repository.getMovieDetail(movieId);
      _castList = await _repository.getMovieCredits(movieId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
