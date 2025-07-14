import 'package:cinemarket/features/mypage/model/order/order_review_image.dart';

class OrderDetailReview {
  final String id;
  final int rating;
  final String comment;
  final List<OrderReviewImage> images;

  OrderDetailReview({
    required this.id,
    required this.rating,
    required this.comment,
    required this.images,
  });

  factory OrderDetailReview.fromJson(Map<String, dynamic> json) {
    return OrderDetailReview(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      images: (json['images'] as List)
          .map((e) => OrderReviewImage.fromJson(e))
          .toList(),
    );
  }
}
