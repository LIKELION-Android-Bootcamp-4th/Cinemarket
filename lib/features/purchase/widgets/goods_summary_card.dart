import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class GoodsSummaryCard extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int pricePerItem;

  const GoodsSummaryCard({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.pricePerItem
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          color: AppColors.innerWidget,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('상품명', style: AppTextStyle.body),
              const SizedBox(height: 4),
              const Text('⭐ 4.5', style: TextStyle(color: Colors.orange)),
              const SizedBox(height: 4),
              Text('${pricePerItem * quantity}원', style: AppTextStyle.body),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.remove, color: Colors.white),
                  ),
                  Text('$quantity', style: AppTextStyle.body),
                  IconButton(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}