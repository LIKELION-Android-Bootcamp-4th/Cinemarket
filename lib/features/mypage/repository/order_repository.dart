import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/service/order_service.dart';
import 'package:cinemarket/features/mypage/service/review_service.dart';

class OrderRepository {
  final OrderService _service = OrderService();
  final ReviewService _reviewService = ReviewService();

  Future<ListResponse<Order>> getOrders() async {
    try {
      final response = await _service.fetchOrders();

      final parsed = ListResponse<Order>.fromJson(
        response.data,
            (json) => Order.fromJson(json as Map<String, dynamic>),
      );

      for (final order in parsed.items) {
        for (final orderItem in order.items) {
          if (orderItem.movieTitle == null || orderItem.movieTitle!.isEmpty) {
            final productId = orderItem.productId.id;
            if (productId.isNotEmpty) {
              final contentId = await _reviewService.fetchContentIdByProductId(productId);
              if (contentId != null) {
                final movieTitle = await _reviewService.fetchMovieTitleByContentId(contentId);
                orderItem.movieTitle = movieTitle ?? '';
              }
            }
          }
        }
      }

      return parsed;
    } catch (e) {
      throw Exception('주문 목록 파싱 실패: $e');
    }
  }
}
