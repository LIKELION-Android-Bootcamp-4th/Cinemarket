class ReviewStats {
  final double averageRating;
  final int totalReviews;
  final Map<String, int> ratingDistribution;

  ReviewStats({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  factory ReviewStats.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ReviewStats(
        averageRating: 0.0,
        totalReviews: 0,
        ratingDistribution: {},
      );
    }

    return ReviewStats(
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      ratingDistribution: json['ratingDistribution'] != null
          ? Map<String, int>.from(json['ratingDistribution'])
          : {},
    );
  }
}
