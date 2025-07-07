import 'package:cinemarket/core/theme/app_colors.dart';
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

  const PurchaseScreen({super.key, required this.cartItems, });

  @override
  State<PurchaseScreen> createState() => _PurchaseScreen();
}


class _PurchaseScreen extends State<PurchaseScreen> {
  late List<CartItem> cartItems;

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


  int get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price*item.quantity);

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
        onPressed: () {
          // 버튼 이벤트
          CommonToast.show(
            context: context,
            message: '구매가 완료되었습니다.',
            type: ToastificationType.success,
          );
          Future.delayed(const Duration(milliseconds: 600), () {
            context.go('/mypage'); // 구매후 메인 화면? 마이페이지 주문 내역 화면?
          });
        },
      ),
    );
  }
}