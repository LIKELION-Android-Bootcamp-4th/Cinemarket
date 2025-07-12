import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/home/repository/best_movie_repository.dart';
import 'package:flutter/material.dart';

class BestMovieViewModel extends ChangeNotifier {
  final BestMovieRepository _repository = BestMovieRepository();

  List<TmdbMovie> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TmdbMovie> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadTrendingMovies({bool force = false}) async {
    if (!force && movies.isNotEmpty) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _movies = await _repository.fetchTrendingMovies();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}