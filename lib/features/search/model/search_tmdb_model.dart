class SearchTmdbModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final double popularity;

  SearchTmdbModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.popularity,
  });

  factory SearchTmdbModel.fromJson(Map<String, dynamic> json) {
    return SearchTmdbModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      popularity: (json['popularity'] ?? 0).toDouble(),
    );
  }
}