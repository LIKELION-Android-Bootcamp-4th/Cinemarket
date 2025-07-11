class OrderDetailItem {
  final String productId;
  final String productName;
  final String productDescription;
  final int productPrice;
  final String? productImage;
  final String productStatus;
  final int quantity;
  final int unitPrice;
  final int totalPrice;
  final Map<String, dynamic> options;
  final int currentStock;
  final String stockType;

  OrderDetailItem({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    this.productImage,
    required this.productStatus,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.options,
    required this.currentStock,
    required this.stockType,
  });

  factory OrderDetailItem.fromJson(Map<String, dynamic> json) {
    return OrderDetailItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productDescription: json['productDescription'] as String,
      productPrice: json['productPrice'] as int,
      productImage: json['productImage'] as String?,
      productStatus: json['productStatus'] as String,
      quantity: json['quantity'] as int,
      unitPrice: json['unitPrice'] as int,
      totalPrice: json['totalPrice'] as int,
      options: json['options'] as Map<String, dynamic>,
      currentStock: json['currentStock'] as int,
      stockType: json['stockType'] as String,
    );
  }
}