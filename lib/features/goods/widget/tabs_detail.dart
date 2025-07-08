import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/expandable_text.dart';
import 'package:flutter/material.dart';

List<Widget> getTabsDetailWidgets(String description) {
  return [
    const Text('상세 설명', style: AppTextStyle.headline),
    SizedBox(height: 8,),
    ExpandableText(
      textWidget: Text(description, style: AppTextStyle.bodySmall),
    ),
  ];
}