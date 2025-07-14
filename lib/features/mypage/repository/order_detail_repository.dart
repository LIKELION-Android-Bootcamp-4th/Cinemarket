import 'package:cinemarket/features/mypage/model/orderdetail/order_detail.dart';
import 'package:cinemarket/features/mypage/service/order_service.dart';

class OrderDetailRepository {
  final OrderService _service = OrderService();

  Future<OrderDetail> fetchOrderDetail(String orderId) {
    return _service.fetchOrderDetail(orderId);
  }

}
