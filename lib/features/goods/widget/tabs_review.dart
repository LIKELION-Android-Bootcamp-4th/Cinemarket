import 'package:cinemarket/core/router/router.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/detail/widget/my_review_widget.dart';
import 'package:cinemarket/widgets/review_item.dart';
import 'package:flutter/material.dart';

/***
 * 좋아요 순 또는 최신순으로 10개만 리뷰 가져오기
 * UI는 기존 리뷰 목록과 동일하지만 하단의 좋아요/싫어요 버튼만 제거
 */
List<Widget> getTabsReviewWidgets() {
  return [
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('리뷰', style: AppTextStyle.headline),
        const Spacer(),
        GestureDetector(
          onTap: () {
            router.push('/goods/detail/review');
          },
          child: const Text('더보기', style: AppTextStyle.point),
        ),
      ],
    ),
  ];
}