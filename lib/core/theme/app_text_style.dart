import 'package:flutter/material.dart';
import 'app_colors.dart';


// 추후 업데이트 예정
class AppTextStyle {
  static const TextStyle headline = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle point = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: AppColors.textPoint,
  );
}
