import 'package:cinemarket/features/mypage/model/review_image.dart';
import 'package:cinemarket/features/mypage/model/review_product.dart';

class Review {
  final String id; //reviewId
  final int rating; //별점
  final String movieTitle; //영화 제목
  final String comment; //리뷰 내용
  final List<ReviewImage> images; //리뷰 이미지
  final ReviewProduct product; //리뷰 상품
  final DateTime createdAt;

  Review({
    required this.id,
    required this.rating,
    required this.movieTitle,
    required this.comment,
    required this.images,
    required this.product,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      rating: json['rating'] as int,
      movieTitle: json['movieTitle'] as String,
      comment: json['comment'] as String,
      images: (json['images'] as List)
          .map((img) => ReviewImage.fromJson(img))
          .toList(),
      product: ReviewProduct.fromJson(json['product']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

