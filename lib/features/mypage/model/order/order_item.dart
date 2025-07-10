import 'package:cinemarket/features/mypage/model/order/order_item_product.dart';

class OrderItem {
  final OrderItemProduct productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int totalPrice;
  final String? productImage;
  final String stockType;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.productImage,
    required this.stockType,
  });

  factory OrderItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return OrderItem(
        productId: OrderItemProduct(id: '', name: ''),
        productName: '',
        quantity: 0,
        unitPrice: 0,
        totalPrice: 0,
        productImage: null,
        stockType: '',
      );
    }
    return OrderItem(
      productId: OrderItemProduct.fromJson(json['productId']),
      productName: json['productName'] ?? '',
      quantity: json['quantity'] ?? 0,
      unitPrice: json['unitPrice'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      productImage: json['productImage'],
      stockType: json['stockType'] ?? '',
    );
  }
}