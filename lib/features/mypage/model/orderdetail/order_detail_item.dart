
import 'package:cinemarket/features/mypage/model/orderdetail/order_detail_review.dart';

class OrderDetailItem {
  final String id;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int totalPrice;
  final String productImage;
  final OrderDetailReview? review;

  OrderDetailItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.productImage,
    this.review,
  });

  factory OrderDetailItem.fromJson(Map<String, dynamic> json) {
    return OrderDetailItem(
      id: json['id'],
      productName: json['productName'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      totalPrice: json['totalPrice'],
      productImage: json['productImage'],
      review: json['review'] != null
          ? OrderDetailReview.fromJson(json['review'])
          : null,
    );
  }
}
