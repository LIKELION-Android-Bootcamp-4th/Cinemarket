import 'dart:convert';
import 'dart:io';

import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/core/network/tmdb_client.dart';
import 'package:cinemarket/features/mypage/model/review_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReviewService {
  final _dio = ApiClient.dio;
  final _tmdbDio = TmdbClient.dio;
  final _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';

  Future<Response> fetchMyReviews({
    int page = 1,
    int limit = 10,
    int? rating,
    String sort = 'createdAt',
  }) {
    return _dio.get('/api/mypage/reviews', queryParameters: {
      'page': page,
      'limit': limit,
      'rating': rating,
      'sort': sort,
    });
  }

  Future<String?> fetchContentIdByProductId(String productId) async {
    try {
      final response = await _dio.get('/api/content-product/contents/$productId');
      final items = response.data['data']['items'] as List<dynamic>;
      if (items.isNotEmpty) {
        final contentId = items[0]['contentId'] as int?;
        return contentId?.toString();
      }
      return null;
    } catch (e) {
      print('Error fetching contentId: $e');
      return null;
    }
  }


  Future<String?> fetchMovieTitleByContentId(String contentId) async {
    try {
      final response = await _tmdbDio.get(
        '/movie/$contentId',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'ko-KR',
        },
      );
      return response.data['title'] as String?;
    } catch (e) {
      print('Error fetching movie title from TMDB: $e');
      return null;
    }
  }

  Future<bool> deleteReview(String reviewId) async {
    try {
      final response = await _dio.delete('/api/reviews/$reviewId');
      return response.data['success'] == true;
    } catch (e) {
      print('Error deleting review: $e');
      return false;
    }
  }

  Future<bool> updateReview({
    required String reviewId,
    required int rating,
    required String comment,
    required List<String> keepImageIds,
    required List<File> newImages,
  }) async {
    try {
      final formData = FormData.fromMap({
        'rating': rating,
        'comment': comment,
        'keepImageIds': jsonEncode(keepImageIds),
        'newImages': [
          for (final image in newImages)
            await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
        ]
      });

      final response = await _dio.put('/api/reviews/$reviewId', data: formData);

      return response.data['success'] == true;
    } catch (e) {
      print('리뷰 수정 실패: $e');
      return false;
    }
  }

  Future<bool> createReview({
    required String productId,
    required ReviewRequest request,
  }) async {
    final dio = ApiClient.dio;

    final formData = request.toFormData();

    final response = await dio.post(
      '/api/products/$productId/reviews',
      data: formData,
    );

    if (response.statusCode != 200 || response.data['success'] != true) {
      return true;
    } else {
      throw Exception('리뷰 작성 실패: ${response.data['message']}');
    }
  }



}