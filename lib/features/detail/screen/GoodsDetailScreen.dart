import 'package:flutter/material.dart';

class GoodsDetailScreen extends StatelessWidget {
  const GoodsDetailScreen({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('굿즈 상세 화면'),
      ),
    );
  }
}