import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String price;
  final int quantity;

  const CartItem({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.grey,
      child: ListTile(
        leading: Checkbox(value: true, onChanged: (_) {}),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text('수량: $quantity', style: const TextStyle(color: Colors.white70)),
        trailing: Text(price, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}