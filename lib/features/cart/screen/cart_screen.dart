import 'package:cinemarket/features/cart/widgets/cart_bottom_bar_widgets.dart';
import 'package:cinemarket/features/cart/widgets/cart_empty_view_widgets.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required List items});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      name: '아이언맨 피규어',
      quantity: 1,
      price: 25000,
      imageUrl: '', // 이미지
    ),
    CartItem(
      name: '아이언맨 텀블러',
      quantity: 1,
      price: 18000,
      imageUrl: '',
    ),
  ];

  void toggleSelection(int index) {
    setState(() {
      cartItems[index].isSelected = !cartItems[index].isSelected;
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  void toggleAll(bool? checked) {
    setState(() {
      for (var item in cartItems) {
        item.isSelected = checked ?? false;
      }
    });
  }

  void deleteSelected() {
    setState(() {
      cartItems.removeWhere((item) => item.isSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = cartItems.where((item) => item.isSelected).toList();
    final totalPrice = selectedItems.fold(0, (sum, item) => sum + item.price * item.quantity);
    final allSelected = cartItems.isNotEmpty && cartItems.every((item) => item.isSelected);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: cartItems.isEmpty
            ? const CartEmptyView()
            : Column(
          children: [
            // 상단 바
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('장바구니', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 48), // 우측 여백
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Colors.grey[900],
              child: Row(
                children: [
                  Checkbox(
                    value: allSelected,
                    onChanged: toggleAll,
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                  ),
                  const Text('전체선택', style: TextStyle(color: Colors.white)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: deleteSelected,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  //장바구니 아이템 목록 출력
                  ...cartItems.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return CartItemWidgets(
                      item: item,
                      onChanged: () => toggleSelection(index),
                      onIncrease: () => increaseQuantity(index),
                      onDecrease: () => decreaseQuantity(index),
                    );
                  }),

                  const SizedBox(height: 12),

                ],
              ),
            ),
            // 하단 바
            if (cartItems.isNotEmpty)
              CartBottomBar(itemCount: selectedItems.length, totalPrice: totalPrice),
          ],
        ),
      ),
    );
  }
}