import 'package:flutter/material.dart';

class CartControlBar extends StatelessWidget {
  final bool allSelected;
  final ValueChanged<bool?> onToggleAll;
  final VoidCallback onDelete;

  const CartControlBar({
    super.key,
    required this.allSelected,
    required this.onToggleAll,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: const Border(
          top: BorderSide(color: Colors.white12),
        ),
      ),
      child: Row(
        children: [
          // 전체선택 체크박스
          Checkbox(
            value: allSelected,
            onChanged: onToggleAll,
            checkColor: Colors.white,
            activeColor: Colors.black,
          ),
          const SizedBox(width: 8),
          const Text('전체선택', style: TextStyle(color: Colors.white)),

          const Spacer(),

          // 휴지통 아이콘
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}