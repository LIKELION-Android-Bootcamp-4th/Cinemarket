import 'package:flutter/material.dart';

class GoodsItem extends StatelessWidget {
  const GoodsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text('상품', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}