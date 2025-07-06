import 'package:cinemarket/features/mypage/detail/component/edit_profile_component.dart';
import 'package:cinemarket/features/mypage/detail/component/fix_review_component.dart';
import 'package:cinemarket/features/mypage/detail/component/my_review_component.dart';
import 'package:cinemarket/features/mypage/detail/component/order_history_component.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPageDetailScreen extends StatelessWidget {
  const MyPageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String menu = GoRouterState.of(context).extra as String? ?? '';

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
      case 'my_review':
        title = '나의 리뷰';
        bodyWidget = const MyReviewComponent();
        break;
      case 'fix_review' :
        title = '리뷰 수정';
        bodyWidget = const FixReviewComponent();
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
