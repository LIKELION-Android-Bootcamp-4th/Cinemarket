class GoodsReviewImage {
  final String id;
  final String url;

  GoodsReviewImage({required this.id, required this.url});

  factory GoodsReviewImage.fromJson(Map<String, dynamic> json) {
    return GoodsReviewImage(
      id: json['id'],
      url: json['url'],
    );
  }
}

class GoodsReviewUser {
  final String id;
  final String nickName;

  GoodsReviewUser({required this.id, required this.nickName});

  factory GoodsReviewUser.fromJson(Map<String, dynamic> json) {
    return GoodsReviewUser(
      id: json['id'],
      nickName: json['nickName'],
    );
  }
}

class GoodsReview {
  final String id;
  final int rating;
  final String comment;
  final List<GoodsReviewImage> images;
  final int likeCount;
  final DateTime createdAt;
  final GoodsReviewUser user;

  GoodsReview({
    required this.id,
    required this.rating,
    required this.comment,
    required this.images,
    required this.likeCount,
    required this.createdAt,
    required this.user,
  });

  factory GoodsReview.fromJson(Map<String, dynamic> json) {
    return GoodsReview(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      images: (json['images'] as List<dynamic>)
          .map((e) => GoodsReviewImage.fromJson(e))
          .toList(),
      likeCount: json['likeCount'],
      createdAt: DateTime.parse(json['createdAt']),
      user: GoodsReviewUser.fromJson(json['user']),
    );
  }
}
