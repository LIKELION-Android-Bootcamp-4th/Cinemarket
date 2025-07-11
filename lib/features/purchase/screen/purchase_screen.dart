import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/auth/viewmodel/my_page_viewmodel.dart';
import 'package:cinemarket/features/cart/service/cart_service.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/features/purchase/widgets/bottom_action_button.dart';
import 'package:cinemarket/features/purchase/widgets/delivery_info_cart.dart';
import 'package:cinemarket/features/purchase/widgets/goods_summary_card.dart';
import 'package:cinemarket/features/purchase/widgets/payment_info_card.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
  final memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyPageViewModel>().initialize();
    });
  }

  @override
  void dispose() {
    memoController.dispose();
    super.dispose();
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
    final myPageViewModel = context.watch<MyPageViewModel>();
    final address = myPageViewModel.address1;
    final zipCode = myPageViewModel.zipCode;
    final name = myPageViewModel.recipientName;

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

          // 배송지 카드 (주소 선택 포함)
          DeliveryInfoCard(
            address: address,
            zipCode: zipCode,
            onAddressChanged: (newAddress, newZip) {
              myPageViewModel.setAddress(newAddress, newZip);
            },
          ),

          const SizedBox(height: 16),
          PaymentInfoCard(items: cartItems),

          const SizedBox(height: 16),
          // TextField(
          //   controller: memoController,
          //   style: const TextStyle(color: Colors.white),
          //   decoration: const InputDecoration(
          //     labelText: '배송 메모 (선택)',
          //     labelStyle: TextStyle(color: Colors.white),
          //     filled: true,
          //     fillColor: Colors.grey,
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          const SizedBox(height: 80),
        ],
      ),
      bottomNavigationBar: BottomActionButton(
        label: '구매',
        onPressed: () async {
          if (address == null || zipCode == null) {
            CommonToast.show(
              context: context,
              message: '배송지를 선택해주세요.',
              type: ToastificationType.error,
            );
            return;
          }

          try {
            final cartIds = cartItems.map((e) => e.cartId).toList();
            await _cartService.checkoutCart(
              cartIds: cartIds,
              recipient: name,
              address: address,
              phone: myPageViewModel.safePhone,
              zipCode: zipCode!,
              memo: memoController.text,
            );
            CommonToast.show(
              context: context,
              message: '구매가 완료되었습니다.',
              type: ToastificationType.success,
            );
            Future.delayed(const Duration(seconds: 1), () {
              context.go('/home');
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