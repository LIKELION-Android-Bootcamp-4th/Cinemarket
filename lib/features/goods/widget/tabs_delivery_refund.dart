import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

List<Widget> getTabsDeliveryRefundWidgets() {
  return [
    const SizedBox(
      height: 400,
      child: Center(child: Text('준비 중 입니다.', style: AppTextStyle.headline)),
    ),
  ];
}