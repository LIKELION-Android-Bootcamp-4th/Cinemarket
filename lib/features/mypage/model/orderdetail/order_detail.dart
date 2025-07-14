import 'package:cinemarket/features/mypage/model/order/status_history.dart';
import 'package:cinemarket/features/mypage/model/orderdetail/detail_shipping_info.dart';
import 'package:cinemarket/features/mypage/model/orderdetail/order_detail_item.dart';

class OrderDetail {
  final String id;
  final String orderNumber;
  final String status;
  final int subtotalAmount;
  final int shippingCost;
  final int totalAmount;
  final String memo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DetailShippingInfo shippingInfo;
  final List<OrderDetailItem> items;
  final List<StatusHistory> statusHistory;

  OrderDetail({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.subtotalAmount,
    required this.shippingCost,
    required this.totalAmount,
    required this.memo,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingInfo,
    required this.items,
    required this.statusHistory,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      status: json['status'] as String,
      subtotalAmount: json['subtotalAmount'] as int,
      shippingCost: json['shippingCost'] as int,
      totalAmount: json['totalAmount'] as int,
      memo: json['memo'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      shippingInfo: DetailShippingInfo.fromJson(json['shippingInfo']),
      items: (json['items'] as List)
          .map((item) => OrderDetailItem.fromJson(item))
          .toList(),
      statusHistory: (json['statusHistory'] as List)
          .map((s) => StatusHistory.fromJson(s))
          .toList(),
    );
  }
}
