import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String name;
  int quantity;
  final int price;
  final String imageUrl;
  bool isSelected;

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    this.isSelected = false,
  });
}

class CartItemWidgets extends StatelessWidget {
  final CartItem item;
  final VoidCallback onChanged;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemWidgets({
    super.key,
    required this.item,
    required this.onChanged,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final isChecked = item.isSelected;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //체크박스
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isChecked ? Colors.black : Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Checkbox(
                value: isChecked,
                onChanged: (_) => onChanged(),
                activeColor: Colors.black,
                checkColor: Colors.white,
                side: BorderSide.none,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 이미지
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.imageUrl.isNotEmpty
                    ? Image.network(
                  item.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: const Icon(Icons.image, color: Colors.white30),
                ),
              ),
              const SizedBox(width: 12),

              // 상품 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 32),
                    //수량
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove,
                              size: 18, color: Colors.white),
                          onPressed: onDecrease,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          child: Text('${item.quantity}',
                              style:
                              const TextStyle(color: Colors.white)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add,
                              size: 18, color: Colors.white),
                          onPressed: onIncrease,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // 가격
              Text(
                '${item.price}원', style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}