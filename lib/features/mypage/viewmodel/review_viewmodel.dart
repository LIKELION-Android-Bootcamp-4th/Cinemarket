import 'dart:io';

import 'package:cinemarket/features/mypage/model/review.dart';
import 'package:cinemarket/features/mypage/model/review_request.dart';
import 'package:cinemarket/features/mypage/repository/review_repository.dart';
import 'package:flutter/material.dart';

class ReviewViewModel extends ChangeNotifier {
  final ReviewRepository _repository = ReviewRepository();

  List<Review> _reviews = [];
  List<Review> get reviews => _reviews;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  Future<void> loadReviews({
    int page = 1,
    int limit = 20,
    int? rating,
    String sort = 'createdAt',
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedReviews = await _repository.fetchMyReviews(
        page: page,
        limit: limit,
        rating: rating,
        sort: sort,
      );
      _reviews = fetchedReviews;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteReviewById(String reviewId) async {
    final result = await _repository.deleteReview(reviewId);
    if (result) {
      _reviews.removeWhere((r) => r.id == reviewId);
      notifyListeners();
    }
    return result;
  }

  Future<bool> updateReview({
    required String reviewId,
    required int rating,
    required String comment,
    required List<String> keepImageIds,
    required List<File> newImages,
  }) async {
    return await _repository.updateReview(
      reviewId: reviewId,
      rating: rating,
      comment: comment,
      keepImageIds: keepImageIds,
      newImages: newImages,
    );
  }


  Future<void> submitReview({
    required String productId,
    required ReviewRequest request,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    try {
      await _repository.createReview(productId: productId, request: request);
      _isSuccess = true;
    } catch (e) {
      _errorMessage = '리뷰 작성 실패: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



}