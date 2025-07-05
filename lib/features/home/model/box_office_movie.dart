class BoxOfficeMovie {
  final String rank;
  final String movieNm;
  final String openDt;
  final String audiCnt;

  BoxOfficeMovie({
    required this.rank,
    required this.movieNm,
    required this.openDt,
    required this.audiCnt,
  });

  factory BoxOfficeMovie.fromJson(Map<String, dynamic> json) {
    return BoxOfficeMovie(
      rank: json['rank'] as String,
      movieNm: json['movieNm'] as String,
      openDt: json['openDt'] as String? ?? '',
      audiCnt: json['audiCnt'] as String? ?? '0',
    );
  }
}
