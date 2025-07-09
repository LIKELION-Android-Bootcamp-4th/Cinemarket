import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/home/repository/home_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  List<TmdbMovie> movies = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadMovies(String date) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movies = await _repository.fetchBoxOfficeWithTmdbDetails(date);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
