import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class SearchSectionTitle extends StatelessWidget {
  final String title;

  const SearchSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(title, style: AppTextStyle.headline),
    );
  }
}