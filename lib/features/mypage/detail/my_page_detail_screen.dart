import 'package:cinemarket/features/mypage/detail/component/edit_profile_component.dart';
import 'package:cinemarket/features/mypage/detail/component/fix_review_component.dart';
import 'package:cinemarket/features/mypage/detail/component/kpostal_widget.dart';
import 'package:cinemarket/features/mypage/detail/component/my_review_component.dart';
import 'package:cinemarket/features/mypage/detail/component/order_detail_component.dart';
import 'package:cinemarket/features/mypage/detail/component/order_history_component.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';

class MyPageDetailScreen extends StatelessWidget {
  const MyPageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic extraData = GoRouterState.of(context).extra;
    String menu = '';
    int? reviewId;

    if(extraData is Map<String, dynamic>) {
      menu = extraData['where'] as String? ?? '';
      reviewId = extraData['reviewId'] as int? ?? 0;
    } else if (extraData is String) {
      menu = extraData;
    }



    String title = '';
    Widget bodyWidget;

    switch (menu) {
      case 'edit_profile':
        title = '회원 정보 수정';
        bodyWidget = const EditProfileComponent();
        break;
      case 'order_history':
        title = '주문 내역';
        bodyWidget = const OrderHistoryComponent();
        break;
      case 'order_detail':
        title = '주문상세내역';
        bodyWidget = const OrderDetailComponent();
        break;
      case 'my_review':
        title = '나의 리뷰';
        bodyWidget = const MyReviewComponent();
      case 'kpostal':
        title = '주소 검색';
        bodyWidget = const KpostalAddressSearchWidget();
        break;
      case 'fix_review' :
        title = '리뷰 수정';
        bodyWidget = FixReviewComponent(int: reviewId);
        break;
      default:
        title = '에러';
        bodyWidget = const Center(child: Text('에러 페이지입니다.', style: TextStyle(color: Colors.white)));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: title),
      body: bodyWidget,
    );
  }
}
