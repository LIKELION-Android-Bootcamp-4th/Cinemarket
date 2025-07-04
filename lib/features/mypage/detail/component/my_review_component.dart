import 'package:flutter/material.dart';

class MyReviewComponent extends StatelessWidget {
  const MyReviewComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '리뷰 목록 컴포넌트',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
