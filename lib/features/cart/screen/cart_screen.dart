import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/cart/widgets/cart_bottom_bar_widgets.dart';
import 'package:cinemarket/features/cart/widgets/cart_empty_view_widgets.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_tile.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();

    cartItems = [
      CartItem(name: '영화 굿즈 인형', quantity: 1, price: 150000, isSelected: true),
      CartItem(name: '한정판 포스터', quantity: 2, price: 10000, isSelected: true),
    ];
    selectAll = cartItems.isNotEmpty && cartItems.every((item) => item.isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('장바구니'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
      ),
      body: cartItems.isEmpty
          ? const CartEmptyViewWidgets()
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Checkbox(
                  value: selectAll,
                  onChanged: (value) {
                    setState(() {
                      selectAll = value!;
                      for (var item in cartItems) {
                        item.isSelected = value;
                      }
                    });
                  },
                  activeColor: Colors.black,
                ),
                Text('전체 선택', style: TextStyle(color: AppColors.textSecondary)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      cartItems.removeWhere((item) => item.isSelected);
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemTile(
                  item: cartItems[index],
                  onChanged: (checked) {
                    setState(() {
                      cartItems[index].isSelected = checked;
                      selectAll = cartItems.isNotEmpty &&
                          cartItems.every((item) => item.isSelected);
                    });
                  },
                  onIncrease: () {
                    setState(() {
                      cartItems[index].quantity++;
                    });
                  },
                  onDecrease: () {
                    setState(() {
                      if (cartItems[index].quantity > 1) {
                        cartItems[index].quantity--;
                      }
                    });
                  },
                );
              },
            ),
          ),
          CartBottomBarWidgets(
            items: cartItems,
            onSelectAll: (bool value) {
              setState(() {
                selectAll = value;
                for (var item in cartItems) {
                  item.isSelected = value;
                }
              });
            },
          )
        ],
      ),
    );
  }
}