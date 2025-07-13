import 'dart:io';

import 'package:cinemarket/features/mypage/model/review.dart';
import 'package:cinemarket/features/mypage/model/review_request.dart';
import 'package:cinemarket/features/mypage/service/review_service.dart';

class ReviewRepository {
  final ReviewService _service = ReviewService();

  Future<List<Review>> fetchMyReviews({
    int page = 1,
    int limit = 10,
    int? rating,
    String sort = 'createdAt',
  }) async {
    final response = await _service.fetchMyReviews(
      page: page,
      limit: limit,
      rating: rating,
      sort: sort,
    );

    final List<dynamic> items = response.data['data']['items'];
    final List<Review> reviews = [];

    for (final item in items) {
      final productJson = item['product'];
      final productId = productJson['id'] as String?;

      String movieTitle = '';
      if (productId != null) {
        final contentId = await _service.fetchContentIdByProductId(productId);
        if (contentId != null) {
          final fetchedTitle = await _service.fetchMovieTitleByContentId(contentId);
          movieTitle = fetchedTitle ?? '';
        }
      }

      final review = Review.fromJson({
        ...item,
        'movieTitle': movieTitle, // movieTitle 강제 삽입
      });

      reviews.add(review);
    }

    return reviews;
  }

  Future<bool> deleteReview(String reviewId) async {
    return await _service.deleteReview(reviewId);
  }

  Future<bool> updateReview({
    required String reviewId,
    required int rating,
    required String comment,
    required List<String> keepImageIds,
    required List<File> newImages,
  }) {
    return _service.updateReview(
      reviewId: reviewId,
      rating: rating,
      comment: comment,
      keepImageIds: keepImageIds,
      newImages: newImages,
    );
  }

  Future<void> createReview({
    required String productId,
    required ReviewRequest request,
  }) async {
    return _service.createReview(productId: productId, request: request);
  }
}
