import 'package:cinemarket/features/mypage/model/review.dart';
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
          if (fetchedTitle != null) {
            print('fetchedTitle: $fetchedTitle');
          }
          movieTitle = fetchedTitle ?? '';
        }
      }

      final review = Review.fromJson({
        ...item,
        'movieTitle': movieTitle, // movieTitle 강제 삽입
      });

      reviews.add(review);
    }

    for (final review in reviews) {
      print('review: ${review.movieTitle}');
    }

    return reviews;
  }

  Future<bool> deleteReview(String reviewId) async {
    return await _service.deleteReview(reviewId);
  }

}
