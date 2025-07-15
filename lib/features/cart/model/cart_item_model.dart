class CartItemModel {
  final String cartId;
  final String productId;
  final String name;
  final String description;
  final int price;
  final int stock;
  final int quantity;
  final String? image;

  CartItemModel({
    required this.cartId,
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.quantity,
    this.image,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] ?? {};
    final images = product['images'] ?? {};
    final mainImage = images['main'] ?? null;


    return CartItemModel(
      cartId: json['id'] ?? '',
      productId: product['id']?? '',
      name: product['name'] ?? '',
      description: product['description'] ?? '',
      price: product['unitPrice'] ?? 0,
      stock: product['stock'] ?? 0,
      quantity: json['quantity'] ?? 1,
        image: mainImage ?? 'https://i.ebayimg.com/images/g/~NEAAOSw8iBoK2Z9/s-l1600.webp',
    );
  }
}
