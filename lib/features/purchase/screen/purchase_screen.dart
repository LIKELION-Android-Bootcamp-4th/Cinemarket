import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/purchase/widgets/bottom_action_button.dart';
import 'package:cinemarket/features/purchase/widgets/delivery_info_card.dart';
import 'package:cinemarket/features/purchase/widgets/goods_summary_card.dart';
import 'package:cinemarket/features/purchase/widgets/payment_info_card.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreen();
}

class _PurchaseScreen extends State<PurchaseScreen> {
  int quantity = 1;
  final int pricePerItem = 15000;

  void increaseQuantity() {
    setState(() => quantity++);
  }

  void decreaseQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }

  @override
  Widget build(BuildContext context) {
    final int totalPrice = quantity * pricePerItem;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('구매하기'),
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GoodsSummaryCard(
              quantity: quantity,
              onAdd: increaseQuantity,
              onRemove: decreaseQuantity,
              pricePerItem: pricePerItem,
            ),
            const SizedBox(height: 24),
            const DeliveryInfoCard(),
            const SizedBox(height: 24),
            PaymentInfoCard(
              quantity: quantity,
              pricePerItem: pricePerItem,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: BottomActionButton(
        label: '${totalPrice.toString()}원 결제하기',
        onPressed: () {
          // 결제 로직
          CommonToast.show(
            context: context,
            message: '기능 준비중',
            type: ToastificationType.info,
          );
        },
      ),
    );
  }
}