class TmdbMovie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final double popularity;
  final List<Map<String, String>> providers;
  final int cumulativeSales;


  TmdbMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.popularity,
    this.providers = const [],
    this.cumulativeSales = 0,
  });

  factory TmdbMovie.fromJson(Map<String, dynamic> json) {
    return TmdbMovie(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      popularity: (json['popularity'] ?? 0).toDouble(),
      providers: [],
      cumulativeSales: 0,
    );
  }

  TmdbMovie copyWithProviders(List<Map<String, String>> newProviders) {
    return TmdbMovie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      popularity: popularity,
      providers: newProviders,
      cumulativeSales: cumulativeSales,
    );
  }

  TmdbMovie copyWithCumulativeSales(int newSales) {
    return TmdbMovie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      popularity: popularity,
      providers: providers,
      cumulativeSales: newSales,
    );
  }
}
