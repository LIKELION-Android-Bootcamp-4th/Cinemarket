import 'package:cinemarket/features/mypage/model/order/order_review_image.dart';

class OrderReview {
  final String id;
  final int rating;
  final String comment;
  final List<OrderReviewImage> images;

  OrderReview({
    required this.id,
    required this.rating,
    required this.comment,
    required this.images,
  });

  factory OrderReview.fromJson(Map<String, dynamic> json) {
    return OrderReview(
      id: json['id'] ?? '',
      rating: int.tryParse(json['rating'].toString()) ?? 0,
      comment: json['comment'] ?? '',
      images: (json['images'] as List<dynamic>? ?? [])
          .map((img) => OrderReviewImage.fromJson(img))
          .toList(),
    );
  }

}
