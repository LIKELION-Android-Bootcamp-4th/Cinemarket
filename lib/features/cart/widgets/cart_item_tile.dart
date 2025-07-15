import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:flutter/material.dart';


class CartItemTile extends StatelessWidget {
  final CartItem item;
  final ValueChanged<bool> onChanged;
  final void Function(BuildContext context) onIncrease;
  final VoidCallback onDecrease;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onChanged,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final int totalPrice = item.price * item.quantity;
    final String formattedPrice = '${totalPrice.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},')}원';

    final bool shouldBreakLine = totalPrice >= 100000;

    return Card(
      color: AppColors.widgetBackground,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 4),
              child: Checkbox(
                value: item.isSelected,
                onChanged: (value) => onChanged(value!),
                activeColor: Colors.black,
                visualDensity: VisualDensity.compact,
              ),
            ),

            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.innerWidget,
                borderRadius: BorderRadius.circular(8),
                image: item.imageUrl != null && item.imageUrl!.isNotEmpty
                    ? DecorationImage(
                  image: NetworkImage(item.imageUrl!),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: (item.imageUrl == null || item.imageUrl!.trim().isEmpty)
                  ? const Icon(Icons.image_not_supported, color: Colors.grey)
                  : null,
            ),
            const SizedBox(width: 12),

            // 상품 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상품명
                  Text(
                    item.name,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // 수량/가격: 줄바꿈 조건
                  if (shouldBreakLine) ...[
                    Row(
                      children: [
                        IconButton(
                          onPressed: onDecrease,
                          icon: const Icon(Icons.remove, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '${item.quantity}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () => onIncrease(context),
                          icon: const Icon(Icons.add, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        formattedPrice,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        IconButton(
                          onPressed: onDecrease,
                          icon: const Icon(Icons.remove, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '${item.quantity}',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                        IconButton(
                          onPressed: () => onIncrease(context),
                          icon: const Icon(Icons.add, color: Colors.white),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const Spacer(),
                        Text(
                          formattedPrice,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}