class FavoriteItem {
  final String id;
  final FavoriteGoods favoriteGoods;

  FavoriteItem({required this.id, required this.favoriteGoods});

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      favoriteGoods: FavoriteGoods.fromJson(json['entity']),
    );
  }
}

class FavoriteGoods {
  final String id;
  final String name;
  final int price;

  FavoriteGoods({
    required this.id,
    required this.name,
    required this.price,
  });

  factory FavoriteGoods.fromJson(Map<String, dynamic> json) {
    return FavoriteGoods(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }

  @override
  String toString() {
    return 'FavoriteGoods(id : $id, name: $name, price: $price)';
  }
}
