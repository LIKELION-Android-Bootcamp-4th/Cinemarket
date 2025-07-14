import 'package:dio/dio.dart';

class ReviewRequest {
  final int rating;
  final String comment;
  final String? orderId;
  final List<MultipartFile> images;

  ReviewRequest({
    required this.rating,
    required this.comment,
    this.orderId,
    required this.images,
  });

  FormData toFormData() {
    final formDataMap = {
      'rating': rating.toString(),
      'comment': comment,
      if (orderId != null) 'orderId': orderId!,
      'images': images,
    };

    return FormData.fromMap(formDataMap);
  }
}
