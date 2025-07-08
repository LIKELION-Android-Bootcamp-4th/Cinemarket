import 'package:flutter/material.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/movies/repository/movies_repository.dart';


extension MovieSortTypeExtension on MovieSortType {
  String get label {
    switch (this) {
      case MovieSortType.rating:
        return '평점순';
      case MovieSortType.latest:
      default:
        return '최신순';
    }
  }

  static MovieSortType fromLabel(String label) {
    switch (label) {
      case '평점순':
        return MovieSortType.rating;
      case '최신순':
      default:
        return MovieSortType.latest;
    }
  }
}

class MoviesViewModel extends ChangeNotifier {
  final MoviesRepository _repository = MoviesRepository();


  List<TmdbMovie> _movies = [];
  MovieSortType _sortType = MovieSortType.latest;
  bool _isLoading = false;
  String? _errorMessage;

  List<TmdbMovie> get movies => _movies;
  MovieSortType get sortType => _sortType;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String get sortLabel => _sortType.label;

  void changeSortTypeFromLabel(String label) {
    final newSortType = MovieSortTypeExtension.fromLabel(label);
    if (newSortType == _sortType) return;

    print('🔁 sort type changing: $_sortType → $newSortType');

    _sortType = newSortType;
    loadMovies();
  }

  Future<void> loadMovies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.fetchMovies(_sortType);
      _movies = result;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
