import 'package:flutter/material.dart';


class CartEmptyView extends StatelessWidget {
  const CartEmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '장바구니에 담긴 상품이 없습니다.\n원하는 상품을 장바구니에 담아보세요',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: 상품 화면으로 이동
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('바로가기'),
            ),
          ],
        ),
      ),
    );
  }
}