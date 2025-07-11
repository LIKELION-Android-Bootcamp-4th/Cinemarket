import 'package:cinemarket/features/mypage/model/orderdetail/detail_shipping_info.dart';
import 'package:cinemarket/features/mypage/model/orderdetail/order_detail_item.dart';
import 'package:cinemarket/features/mypage/model/orderdetail/user_info.dart';

class OrderDetail {
  final String id;
  final String userId;
  final String companyId;
  final List<OrderDetailItem> items;
  final int totalAmount;
  final String status;
  final DetailShippingInfo shippingInfo;
  final String memo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String orderNumber;
  final UserInfo userInfo;
  final int subtotalAmount;
  final int shippingCost;

  OrderDetail({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.shippingInfo,
    required this.memo,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
    required this.userInfo,
    required this.subtotalAmount,
    required this.shippingCost,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'] as String,
      userId: json['userId'] as String,
      companyId: json['companyId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderDetailItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: json['totalAmount'] as int,
      status: json['status'] as String,
      shippingInfo: DetailShippingInfo.fromJson(json['shippingInfo']),
      memo: json['memo'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      orderNumber: json['orderNumber'] as String,
      userInfo: UserInfo.fromJson(json['userInfo']),
      subtotalAmount: json['subtotalAmount'] as int,
      shippingCost: json['shippingCost'] as int,
    );
  }
}