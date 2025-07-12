class TmdbMovieDetail {
  final String backdropPath;
  final String posterPath;
  final List<String> genres;
  final String releaseYear;
  final int runtime;
  final String overview;
  final String title;
  final double voteAverage;
  final List<Map<String, String>>? providers;

  TmdbMovieDetail({
    required this.backdropPath,
    required this.posterPath,
    required this.genres,
    required this.releaseYear,
    required this.runtime,
    required this.overview,
    required this.title,
    required this.voteAverage,
    required this.providers,
  });

  factory TmdbMovieDetail.fromJson(Map<String, dynamic> json) {
    return TmdbMovieDetail(
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      genres: (json['genres'] as List).map((g) => g['name'] as String).toList(),
      releaseYear: (json['release_date'] as String).split('-')[0],
      runtime: json['runtime'] ?? 0,
      overview: json['overview'] ?? '',
      title: json['title'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      providers: json['providers'] != null
          ? List<Map<String, String>>.from(json['providers'])
          : [],
    );
  }

  TmdbMovieDetail copyWithProviders(List<Map<String, String>> newProviders) {
    return TmdbMovieDetail(
      backdropPath: backdropPath,
      posterPath: posterPath,
      genres: genres,
      releaseYear: releaseYear,
      runtime: runtime,
      overview: overview,
      title: title,
      voteAverage: voteAverage,
      providers: newProviders,
    );
  }
}