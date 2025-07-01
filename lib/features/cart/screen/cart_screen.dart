import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: '장바구니'),
      body: const Center(
        child: Text('장바구니 화면 입니다'),
      ),
    );
  }
}
