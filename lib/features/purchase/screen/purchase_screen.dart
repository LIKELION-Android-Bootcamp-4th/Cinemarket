import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/auth/viewmodel/my_page_viewmodel.dart';
import 'package:cinemarket/features/cart/model/cart_item_model.dart';
import 'package:cinemarket/features/cart/service/cart_service.dart';
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
  final List<CartItemModel> cartItems;

  const PurchaseScreen({super.key, required this.cartItems});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreen();
}

class _PurchaseScreen extends State<PurchaseScreen> {
  late List<CartItemModel> cartItems;
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
      final item = cartItems[index];
      cartItems[index] = CartItemModel(
        cartId: item.cartId,
        productId: item.productId,
        name: item.name,
        description: item.description,
        price: item.price,
        stock: item.stock,
        quantity: item.quantity + 1,
        image: item.image,
      );
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      final item = cartItems[index];
      if (item.quantity > 1) {
        cartItems[index] = CartItemModel(
          cartId: item.cartId,
          productId: item.productId,
          name: item.name,
          description: item.description,
          price: item.price,
          stock: item.stock,
          quantity: item.quantity - 1,
          image: item.image,
        );
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
            address: myPageViewModel.fullAddress,
            zipCode: myPageViewModel.zipCode,
            onAddressChanged: (newAddress, newZip) {
              myPageViewModel.setAddress(newAddress, newZip);
            },
          ),

          const SizedBox(height: 16),
          PaymentInfoCard(items: cartItems),
          const SizedBox(height: 80),
        ],
      ),
      bottomNavigationBar: BottomActionButton(
        label: '구매',
        onPressed: () async {
          final cartIds = cartItems.map((e) => e.cartId).where((id) => id.isNotEmpty).toList();

          if (cartIds.isEmpty) {
            CommonToast.show(
              context: context,
              message: '선택된 상품이 없습니다.',
              type: ToastificationType.error,
            );
            return;
          }

          if(myPageViewModel.address1 == null || myPageViewModel.zipCode == null) {
            CommonToast.show(
              context: context,
              message: '배송지를 선택해주세요',
              type: ToastificationType.error,
            );
            return;
          }

          try {
            await _cartService.checkoutCart(
              cartIds: cartIds,
              recipient: myPageViewModel.recipientName,
              address: '${myPageViewModel.address1??''} ${myPageViewModel.address2 ?? ''}',
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