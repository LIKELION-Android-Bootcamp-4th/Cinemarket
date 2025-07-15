import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


class CartEmptyViewWidgets extends StatelessWidget {
  const CartEmptyViewWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '장바구니에 담긴 상품이 없습니다.\n원하는 상품을 장바구니에 담아보세요',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.widgetBackground,
              ),
              child: Text(
                '뒤로가기',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}