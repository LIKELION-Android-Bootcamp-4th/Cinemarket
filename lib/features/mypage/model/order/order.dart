import 'package:cinemarket/features/mypage/model/order/order_item.dart';

class Order {
  final String id;
  final String orderNumber;
  final int subtotalAmount;
  final int shippingCost;
  final int totalAmount;
  final String status;
  final String memo;
  final List<OrderItem> items;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.subtotalAmount,
    required this.shippingCost,
    required this.totalAmount,
    required this.status,
    required this.memo,
    required this.items,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      subtotalAmount: int.tryParse(json['subtotalAmount'].toString()) ?? 0,
      shippingCost: int.tryParse(json['shippingCost'].toString()) ?? 0,
      totalAmount: int.tryParse(json['totalAmount'].toString()) ?? 0,
      status: json['status'] ?? '',
      memo: json['memo'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }

}
