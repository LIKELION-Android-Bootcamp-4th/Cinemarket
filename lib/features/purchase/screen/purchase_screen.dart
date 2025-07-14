import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/auth/viewmodel/my_page_viewmodel.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/features/purchase/viewmodel/purchase_viewmodel.dart';
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
  final memoController = TextEditingController();
  final address2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final myPageViewModel = context.read<MyPageViewModel>();
    final purchaseViewModel = context.read<PurchaseViewModel>();
    myPageViewModel.initialize().then((_) {
      // 상세주소 값
      address2Controller.text =
      myPageViewModel.address2 != null && myPageViewModel.address2!.trim().isNotEmpty
          ? myPageViewModel.address2!
          : '';

      purchaseViewModel.items = widget.cartItems;
      memoController.text = purchaseViewModel.memoController.text;


    });
  }

  @override
  void dispose() {
    memoController.dispose();
    address2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myPageViewModel = context.watch<MyPageViewModel>();
    final purchaseViewModel = context.watch<PurchaseViewModel>();
    final cartItems = purchaseViewModel.items;

    final address = myPageViewModel.address1;
    final zipCode = myPageViewModel.zipCode;
    final address2 = myPageViewModel.address2;
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
          const Text('굿즈', style: AppTextStyle.headline),
          const SizedBox(height: 8),
          // 상품 리스트
          ...cartItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GoodsSummaryCard(
                  name: item.name,
                  imageUrl: item.imageUrl,
                  quantity: item.quantity,
                  onAdd: () => purchaseViewModel.increaseQuantity(index),
                  onRemove: () => purchaseViewModel.decreaseQuantity(index),
                  pricePerItem: item.price,
                ),
                const SizedBox(height: 16),
              ],
            );
          }),
          const SizedBox(height: 16),

          // 배송지 카드 (주소 선택 포함)
          DeliveryInfoCard(
            address: address,
            zipCode: zipCode,
            address2: address2,
            address2Controller: address2Controller,
            onAddressChanged: (newAddress, newZip) {
              myPageViewModel.setAddress(newAddress, newZip, address2Controller.text);
            },
          ),

          const SizedBox(height: 16),
          PaymentInfoCard(items: cartItems),
          const SizedBox(height: 16),

          const Text('배송 메모', style: AppTextStyle.section),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.innerWidget,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: memoController,
              style: AppTextStyle.body,
              decoration: const InputDecoration.collapsed(
                hintText: '배송 메모를 입력하세요',
                hintStyle: AppTextStyle.body,
              ),
              onChanged: (text) {
                purchaseViewModel.memoController.text = text;
              },
            ),
          ),

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
            await purchaseViewModel.updateQuantitiesToServer();
            await purchaseViewModel.checkout(
              context: context,
              cartIds: cartItems.map((e) => e.cartId).toList(),
              recipient: name,
              address: '$address ${address2Controller.text}',
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