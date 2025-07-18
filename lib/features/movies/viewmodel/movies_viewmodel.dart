import 'package:flutter/material.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/movies/repository/movies_repository.dart';


extension MovieSortTypeExtension on MovieSortType {
  String get label {
    switch (this) {
      case MovieSortType.rating:
        return '평점순';
      case MovieSortType.popularity:
        return '인기순';
      case MovieSortType.reviewCount:
        return '흥행순';
      case MovieSortType.latest:
      default:
        return '최신순';
    }
  }

  static MovieSortType fromLabel(String label) {
    switch (label) {
      case '평점순':
        return MovieSortType.rating;
      case '인기순':
        return MovieSortType.popularity;
      case '흥행순':
        return MovieSortType.reviewCount;
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

  int _currentPage = 1;
  bool _hasMore = true;

  List<TmdbMovie> get movies => _movies;
  MovieSortType get sortType => _sortType;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  String get sortLabel => _sortType.label;

  void changeSortTypeFromLabel(String label) {
    final newSortType = MovieSortTypeExtension.fromLabel(label);
    if (newSortType == _sortType) return;

    _sortType = newSortType;

    _movies.clear();
    _currentPage = 1;
    _hasMore = true;

    loadMovies();
  }

  Future<void> loadMovies({bool force = false}) async {
    if (!force && (_isLoading || !_hasMore)) return;

    if (force) {
      clearMovies();
    }

    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.fetchMovies(_sortType, page: _currentPage);
      if (result.isEmpty) {
        _hasMore = false;
      } else {
        _movies.addAll(result);
        _currentPage++;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMovies() {
    _movies.clear();
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();
  }
}
