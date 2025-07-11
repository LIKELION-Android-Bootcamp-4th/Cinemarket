import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/cart/model/cart_item_model.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:flutter/material.dart';

class PaymentInfoCard extends StatelessWidget {
  final List<CartItemModel> items;

  const PaymentInfoCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final int totalPrice = items.fold(0, (sum, item) => sum + item.price * item.quantity);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('결제 정보', style: AppTextStyle.headline),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.innerWidget,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: _buildRow(
                  item.name,
                  '${item.quantity}개',
                  '${_formatPrice(item.price * item.quantity)}원',
                ),
              )),
              const Divider(color: Color(0xFFe0e0e0)),
              _buildRow('', '', '${_formatPrice(totalPrice)}원', isTotal: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String name, String count, String price,
      {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(name, style: AppTextStyle.body),
        ),
        Expanded(
          flex: 1,
          child: Text(
              count,
              style: AppTextStyle.body,
              textAlign: TextAlign.center
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            price,
            style: AppTextStyle.body.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}

