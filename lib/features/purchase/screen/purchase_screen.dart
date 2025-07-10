import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/cart/service/cart_service.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/features/purchase/widgets/bottom_action_button.dart';
import 'package:cinemarket/features/purchase/widgets/delivery_info_cart.dart';
import 'package:cinemarket/features/purchase/widgets/goods_summary_card.dart';
import 'package:cinemarket/features/purchase/widgets/payment_info_card.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class PurchaseScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const PurchaseScreen({super.key, required this.cartItems});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreen();
}

class _PurchaseScreen extends State<PurchaseScreen> {
  late List<CartItem> cartItems;
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems;
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

  int get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('구매하기'),
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 상품 리스트
          ...cartItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GoodsSummaryCard(
                name: item.name,
                quantity: item.quantity,
                onAdd: () => increaseQuantity(index),
                onRemove: () => decreaseQuantity(index),
                pricePerItem: item.price,
              ),
            );
          }),
          const SizedBox(height: 16),
          const DeliveryInfoCard(),
          const SizedBox(height: 16),
          PaymentInfoCard(items: cartItems),
          const SizedBox(height: 80), // 공간 확보
        ],
      ),
      bottomNavigationBar: BottomActionButton(
        label: '구매',
        onPressed: () async{
          // 구매 완료 토스트 후 마이페이지 이동
          try {
            final cartIds = cartItems.map((e) => e.cartId).toList();
            await _cartService.checkoutCart(cartIds);
            CommonToast.show(
              context: context,
              message: '구매가 완료되었습니다.',
              type: ToastificationType.success,
            );
            Future.delayed(const Duration(milliseconds: 600), () {
              context.go('/home'); // 구매후 마이페이지(주문내역) 이동
            });
          } catch (e) {
            CommonToast.show(
              context: context,
              message: '구매가 실패했습니다.',
              type: ToastificationType.error,
            );
          }
        },
      ),
    );
  }
}