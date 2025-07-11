class OrderReview {
  final String id;
  final String userId;
  final String productId;
  final int rating;
  final String comment;
  final List<ReviewImage> images;
  final bool isDeleted;
  final int likeCount;
  final String companyId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderReview({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.images,
    required this.isDeleted,
    required this.likeCount,
    required this.companyId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderReview.fromJson(Map<String, dynamic> json) {
    return OrderReview(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      productId: json['productId'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => ReviewImage.fromJson(e))
          .toList(),
      isDeleted: json['isDeleted'] ?? false,
      likeCount: json['likeCount'] ?? 0,
      companyId: json['companyId'] ?? '',
      createdBy: json['createdBy'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class ReviewImage {
  final String id;
  final String path;
  final String? mimeType;
  final String? originalName;

  ReviewImage({
    required this.id,
    required this.path,
    this.mimeType,
    this.originalName,
  });

  factory ReviewImage.fromJson(Map<String, dynamic> json) {
    return ReviewImage(
      id: json['id'] ?? '',
      path: json['path'] ?? '',
      mimeType: json['mimeType'],
      originalName: json['originalName'],
    );
  }
}

