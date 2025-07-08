class ReviewStats {
  final double averageRating;
  final int totalReviews;
  final Map<String, int> ratingDistribution;

  ReviewStats({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  factory ReviewStats.fromJson(Map<String, dynamic> json) {
    return ReviewStats(
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: json['totalReviews'],
      ratingDistribution: Map<String, int>.from(json['ratingDistribution']),
    );
  }
}
