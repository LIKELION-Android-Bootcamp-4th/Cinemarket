import 'package:cinemarket/features/mypage/model/order/order_item_product.dart';
import 'package:cinemarket/features/mypage/model/order/order_review.dart';

class OrderItem {
  final OrderItemProduct productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int totalPrice;
  final String? productImage;
  final String stockType;
  final OrderReview? review;
  String? movieTitle;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.productImage,
    required this.stockType,
    this.review,
    this.movieTitle,
  });

  factory OrderItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return OrderItem(
        productId: OrderItemProduct(id: '', name: ''),
        productName: '',
        quantity: 1, // 수량 정보 없음 → 기본값 1
        unitPrice: json?['price'] ?? 0,
        totalPrice: json?['price'] ?? 0,
        productImage: json?['images']?['main'],
        stockType: 'on_sale',
        review: null,
        movieTitle: null,
      );
    }

    return OrderItem(
      productId: OrderItemProduct.fromJson({
        'id': json['id'],
        'name': json['name'],
        'thumbnailImage': json['images']?['main'],
      }),
      productName: json['name'] ?? '',
      quantity: 1, // 수량 정보 없음
      unitPrice: json['price'] ?? 0,
      totalPrice: json['price'] ?? 0,
      productImage: json['images']?['main'],
      stockType: json['status'] ?? 'on_sale',
      review: null,
      movieTitle: null,
    );
  }

}