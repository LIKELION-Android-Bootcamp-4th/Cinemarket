import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class PaymentInfoCard extends StatelessWidget {
  final int quantity;
  final int pricePerItem;

  const PaymentInfoCard({
    super.key,
    required this.quantity,
    required this.pricePerItem,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = quantity * pricePerItem;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('결제 정보', style: AppTextStyle.headline),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.toastBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildRow('상품명', '$quantity개' , '${pricePerItem * quantity}'),
              const SizedBox(height: 8),

              const Divider(color: Color(0xFFe0e0e0)),
              _buildRow('', '', '총합 $totalPrice', isTotal: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String name, String count, String price, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(name, style: AppTextStyle.body)),
        Text(count, style: AppTextStyle.body),
        Text(price,
            style: AppTextStyle.body.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            )
        ),
      ],
    );
  }
}