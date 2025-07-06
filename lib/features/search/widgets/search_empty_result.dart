import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class SearchEmptyResultText extends StatelessWidget {
  const SearchEmptyResultText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        '검색 결과가 없습니다.\n다른 키워드를 검색해주세요.',
        style: AppTextStyle.body,
      ),
    );
  }
}