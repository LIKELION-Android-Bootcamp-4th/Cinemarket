class FavoriteMovie {
  final int contentId;
  final bool isLikedByMe;

  FavoriteMovie({
    required this.contentId,
    required this.isLikedByMe,
  });

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    return FavoriteMovie(
      contentId: json['contentId'] as int,
      isLikedByMe: json['isLikedByMe'] as bool,
    );
  }
}
