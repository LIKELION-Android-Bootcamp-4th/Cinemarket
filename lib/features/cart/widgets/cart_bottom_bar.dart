import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:flutter/material.dart';

class CartBottomBar extends StatelessWidget {
  final List<CartItem> items;
  final ValueChanged<bool> onSelectAll;

  const CartBottomBar({
    Key? key,
    required this.items,
    required this.onSelectAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = items
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.price * item.quantity);
    int selectedCount = items.where((item) => item.isSelected).length;

    return SafeArea(
      top: false,
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // 상단 정렬!
          children: [
            Checkbox(
              value: selectedCount == items.length && items.isNotEmpty,
              onChanged: (value) => onSelectAll(value!),
              activeColor: Colors.black,
            ),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '합계 $selectedCount개',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '${total.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}원',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 48,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedCount > 0) {

                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '결제하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}