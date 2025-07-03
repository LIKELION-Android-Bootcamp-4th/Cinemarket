import 'package:cinemarket/features/detail/screen/GoodsDetailScreen.dart';
import 'package:flutter/material.dart';

class CartBottomBar extends StatelessWidget {
  final int itemCount;
  final int totalPrice;

  const CartBottomBar({
    super.key,
    required this.itemCount,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Text('합계 $itemCount개', style: const TextStyle(color: Colors.white)),
          const Spacer(),
          Text('₩${totalPrice.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ",")}',
              style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 20),

          SizedBox(
            width: 100, // 너비 늘림
            height: 40, // 높이 늘림
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GoodsDetailScreen(title: '',)),
                );
              },
              child: const Text('결제하기'),
            ),
          ),
        ],
      ),
    );
  }
}