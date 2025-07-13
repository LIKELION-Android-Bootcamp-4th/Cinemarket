import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class GoodsSummaryCard extends StatelessWidget {
  final String name;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int pricePerItem;
  final String? imageUrl;

  const GoodsSummaryCard({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.pricePerItem,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final int totalPrice = quantity * pricePerItem;
    final String formattedPrice = '${totalPrice.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    )}원';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageUrl != null
                ? Image.network(
              imageUrl!,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, color: Colors.white),
                );
              },
            )
                : Container(
              width: 100,
              height: 100,
              color: Colors.grey,
              child: const Icon(Icons.image_not_supported, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),

          // 상품 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyle.body), // 상품명
                const SizedBox(height: 4),
                const Text('⭐ 4.5', style: TextStyle(color: Colors.orange)),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formattedPrice, style: AppTextStyle.body),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onRemove,
                          icon: const Icon(Icons.remove, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Text('$quantity', style: AppTextStyle.body),
                        IconButton(
                          onPressed: onAdd,
                          icon: const Icon(Icons.add, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}