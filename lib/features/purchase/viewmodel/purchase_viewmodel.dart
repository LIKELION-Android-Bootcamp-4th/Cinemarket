import 'package:cinemarket/features/cart/service/cart_service.dart';
import 'package:cinemarket/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/features/purchase/service/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseViewModel extends ChangeNotifier {
  final CartService _cartService = CartService();
  final PurchaseService _purchaseService = PurchaseService();

  final TextEditingController memoController = TextEditingController();

  List<CartItem> _items = [];
  List<CartItem> get items => _items;

  set items(List<CartItem> value) {
    _items = value;
    notifyListeners();
  }


  int get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

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

  Future<void> updateQuantitiesToServer() async {
    for (final item in _items) {
      await _cartService.updateCartItemQuantity(
        cartId: item.cartId,
        quantity: item.quantity,
      );
    }
  }

  Future<void> checkout({
    required BuildContext context,
    required List<String> cartIds,
    required String recipient,
    required String address,
    required String phone,
    required String zipCode,
    required String memo,
  }) async {
    await _purchaseService.checkoutCart(
      cartIds: cartIds,
      recipient: recipient,
      address: address,
      phone: phone,
      zipCode: zipCode,
      memo: memoController.text,
    );
    context.read<CartViewModel>().fetchCartCount();
  }

  @override
  void dispose() {
    memoController.dispose(); // 메모 컨트롤러 해제
    super.dispose();
  }
}