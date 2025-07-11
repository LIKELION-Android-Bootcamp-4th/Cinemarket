import 'package:cinemarket/features/mypage/model/order/order_item.dart';
import 'package:cinemarket/features/mypage/model/order/shipping_Info.dart';
import 'package:cinemarket/features/mypage/model/order/status_history.dart';

class Order {
  final String companyId;
  final String? storeId;
  final String userId;
  final List<OrderItem> items;
  final int subtotalAmount;
  final int shippingCost;
  final int totalAmount;
  final String status;
  final ShippingInfo shippingInfo;
  final String memo;
  final String createdBy;
  final List<StatusHistory> statusHistory;
  final List<dynamic> priceChanges;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String orderNumber;
  final String id;

  Order({
    required this.companyId,
    this.storeId,
    required this.userId,
    required this.items,
    required this.subtotalAmount,
    required this.shippingCost,
    required this.totalAmount,
    required this.status,
    required this.shippingInfo,
    required this.memo,
    required this.createdBy,
    required this.statusHistory,
    required this.priceChanges,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
    required this.id,
  });

  factory Order.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Order(
        companyId: '',
        storeId: null,
        userId: '',
        items: [],
        subtotalAmount: 0,
        shippingCost: 0,
        totalAmount: 0,
        status: '',
        shippingInfo: ShippingInfo.fromJson(null),
        memo: '',
        createdBy: '',
        statusHistory: [],
        priceChanges: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        orderNumber: '',
        id: '',
      );
    }

    return Order(
      companyId: json['companyId'] ?? '',
      storeId: json['storeId'],
      userId: json['userId'] ?? '',
      items: (json['products'] as List<dynamic>? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      subtotalAmount: json['subtotalAmount'] ?? 0,
      shippingCost: json['shippingCost'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
      status: json['status'] ?? '',
      shippingInfo: ShippingInfo.fromJson(json['shippingInfo']),
      memo: json['memo'] ?? '',
      createdBy: json['createdBy'] ?? '',
      statusHistory: (json['statusHistory'] as List<dynamic>? ?? [])
          .map((e) => StatusHistory.fromJson(e))
          .toList(),
      priceChanges: json['priceChanges'] ?? [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      orderNumber: json['orderNumber'] ?? '',
      id: json['id'] ?? '',
    );
  }
}