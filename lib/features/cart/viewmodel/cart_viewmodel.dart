import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:flutter/material.dart';
import '../service/cart_service.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService = CartService();

  List<CartItem> _items = [];
  bool _isLoading = false;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;

  int get totalPrice => _items
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + item.price * item.quantity);

  int _cartCount = 0;
  int get cartCount => _cartCount;
  Future<void> fetchCartCount() async {
    try {
      _cartCount = await _cartService.fetchCartCount();
      print('[DEBUG] 장바구니 수량: $_cartCount');
      notifyListeners();
    } catch (e) {
      print('장바구니 개수 조회 실패: $e');
    }
  }

  CartViewModel() {
    fetchCart();
    fetchCartCount();
  }

  Future<void> fetchCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedItems = await _cartService.fetchCartItems();

      _items = fetchedItems.map((e) {
        final safeImage = (e.image != null && e.image!.trim().isNotEmpty) ? e.image : null;
        print('[ViewModel] Safe Image: $safeImage');

        final cartItem = CartItem(
          cartId: e.cartId,
          productId: e.productId,
          name: e.name,
          quantity: e.quantity,
          price: e.price,
          imageUrl: safeImage,
          isSelected: false,
        );
        print('[CartItem 생성됨] name: ${cartItem.name}, price: ${cartItem.price}, quantity: ${cartItem.quantity}');
        return cartItem;
      }).toList();
    } catch (e) {
      _items = [];
      print('장바구니 로딩 에러: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProductToCart({
    required String productId,
    required int quantity,
    required int unitPrice,
    Map<String, dynamic>? options,
    Map<String, dynamic>? discount,
  }) async {
    try {
      await _cartService.addItemToCart(
        productId: productId,
        quantity: quantity,
        unitPrice: unitPrice,
        options: options,
        discount: discount,
      );
      await fetchCart(); // 추가 후 장바구니 새로고침
    } catch (e) {
      print('상품 추가 실패: $e');
    }
  }

  Future<void> removeSelectedItemsFromCart(List<String> cartIds) async {
    try {
      await _cartService.removeItemsFromCart(cartIds);
      await fetchCart(); // 삭제 후 장바구니 갱신
    } catch (e) {
      print('상품 삭제 실패: $e');
    }
  }

  void toggleSelect(int index) {
    _items[index].isSelected = !_items[index].isSelected;
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void toggleSelectAll(bool selectAll) {
    for (final item in _items) {
      item.isSelected = selectAll;
    }
    notifyListeners();
  }
}