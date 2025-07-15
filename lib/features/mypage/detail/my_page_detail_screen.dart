import 'package:cinemarket/features/mypage/detail/widget/edit_password_widget.dart';
import 'package:cinemarket/features/mypage/detail/widget/edit_profile_widget.dart';
import 'package:cinemarket/features/mypage/detail/widget/fix_review_widget.dart';
import 'package:cinemarket/features/mypage/detail/widget/my_review_widget.dart';
import 'package:cinemarket/features/mypage/detail/widget/order_detail_widget.dart';
import 'package:cinemarket/features/mypage/detail/widget/order_history_widget.dart';
import 'package:cinemarket/features/mypage/detail/widget/order_tracking_widget.dart';
import 'package:cinemarket/features/mypage/model/review.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPageDetailScreen extends StatelessWidget {
  const MyPageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic extraData = GoRouterState.of(context).extra;
    String menu = '';
    Review? review;
    String? orderId;

    if (extraData is Map<String, dynamic>) {
      menu = extraData['where'] as String? ?? '';
      review = extraData['review'] as Review?;
      orderId = extraData['orderId'] as String?;
    } else if (extraData is String) {
      menu = extraData;
    }

    String title = '';
    Widget bodyWidget;

    switch (menu) {
      case 'edit_profile':
        title = '회원 정보 수정';
        bodyWidget = const EditProfileWidget();
        break;
      case 'order_history':
        title = '주문 내역';
        bodyWidget = const OrderHistoryWidget();
        break;
      case 'order_detail':
        title = '주문상세내역';
        bodyWidget = OrderDetailWidget(orderId: orderId!);
        break;
      case 'order_tracking':
        return const OrderTrackingWidget();
      case 'my_review':
        title = '나의 리뷰';
        bodyWidget = const MyReviewWidget();
      case 'fix_review':
        title = '리뷰 수정';
        bodyWidget = FixReviewWidget(review: review!);
        break;
      case 'edit_password':
        title = '비밀번호 변경';
        bodyWidget = const EditPasswordWidget();
        break;
      default:
        title = '에러';
        bodyWidget = const Center(
          child: Text('에러 페이지입니다.', style: TextStyle(color: Colors.white)),
        );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: title),
      body: bodyWidget,
    );
  }
}
