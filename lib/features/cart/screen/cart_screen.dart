import 'package:cinemarket/features/cart/widgets/cart%20total_widgets.dart';
import 'package:cinemarket/features/cart/widgets/cart_empty_view_widgets.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<String> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('장바구니'),
      ),
      body: cartItems.isEmpty
          ? const CartEmptyView()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItem(
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity'],
                );
              },
            ),
          ),
          CartTotal(totalCount: cartItems.length),
        ],
      ),
    );
  }
}