import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/goods/widget/bottom_buttons_widget.dart';
import 'package:cinemarket/features/goods/widget/common_tabs_content.dart';
import 'package:cinemarket/features/goods/widget/header_goods_detail.dart';
import 'package:cinemarket/features/goods/widget/tabs_delivery_refund.dart';
import 'package:cinemarket/features/goods/widget/tabs_detail.dart';
import 'package:cinemarket/features/goods/widget/tabs_inquiry.dart';
import 'package:cinemarket/features/goods/widget/tabs_review.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/common_tab_view.dart';
import 'package:flutter/material.dart';

// todo: 더미데이터도 그냥 굿즈아이템 객체를 만드는게 더 편하겠는데?
class GoodsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const GoodsDetailScreen({super.key, required Map<String, dynamic> this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: item['goodsName']),
      backgroundColor: AppColors.background,

      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder:
                  (context, _) => [HeaderGoodsDetail(item: item)],
              body: CommonTabView(
                tabTitles: tabTitles,
                tabViews: [
                  CommonTabsContent(widgets: getTabsDetailWidgets()),
                  CommonTabsContent(widgets: getTabsReviewWidgets()),
                  CommonTabsContent(widgets: getTabsDeliveryRefundWidgets()),
                  CommonTabsContent(widgets: getTabsInquiryWidgets()),
                ],
              ),
            ),
          ),

          const BottomButtonsWidget(),
        ],
      ),
    );
  }
}

final List<String> tabTitles = ['상세 설명', '리뷰', '배송 & 환불', '문의'];
