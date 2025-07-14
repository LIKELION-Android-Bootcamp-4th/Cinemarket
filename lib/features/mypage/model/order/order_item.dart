import 'package:cinemarket/features/mypage/model/order/order_review.dart';

class OrderItem {
  final String id;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int totalPrice;
  final String productImage;
  final OrderReview? review;

  OrderItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.productImage,
    this.review,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? '',
      productName: json['productName'] ?? '',
      quantity: int.tryParse(json['quantity'].toString()) ?? 0,
      unitPrice: int.tryParse(json['unitPrice'].toString()) ?? 0,
      totalPrice: int.tryParse(json['totalPrice'].toString()) ?? 0,
      productImage: json['productImage'] ?? '',
      review: json['review'] != null
          ? OrderReview.fromJson(json['review'])
          : null,
    );
  }

}
