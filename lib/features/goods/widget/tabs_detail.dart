import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/expandable_text.dart';
import 'package:flutter/material.dart';

List<Widget> getTabsDetailWidgets(String description) {
  return [
    const Text('상세 설명', style: AppTextStyle.headline),
    const SizedBox(height: 8),

    if (description.length > 500) ...[
      ExpandableText(
        textWidget: Text(description, style: AppTextStyle.bodySmall),
      ),
    ] else if (description.isEmpty) ...[
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.widgetBackground,
          borderRadius: BorderRadius.circular(4),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Text('상세설명이 없습니다.', style: AppTextStyle.bodySmall),
        ),
      ),
    ] else ...[
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.widgetBackground,
          borderRadius: BorderRadius.circular(4),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Text(description, style: AppTextStyle.bodySmall),
        ),
      ),
    ],
  ];
}