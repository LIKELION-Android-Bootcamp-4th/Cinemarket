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

class FavoriteGoods {  // todo: commonGridview 사용을 위해 결국 Goods 타입 그대로 써야함
  final String id;
  final String name;
  final int price;  // todo: 기존 이미지 객체 변수 + createdAt 변수 추가

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
