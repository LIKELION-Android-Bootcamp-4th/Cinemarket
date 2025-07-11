import 'dart:io';

class ReviewRequest {
  final String productId;
  final String? orderId;
  final int rating;
  final String comment;
  final List<File> images;

  ReviewRequest({
    required this.productId,
    this.orderId,
    required this.rating,
    required this.comment,
    this.images = const [],
  });
}
