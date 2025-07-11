import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_detail_viewmodel.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_recommended_viewmodel.dart';
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
import 'package:provider/provider.dart';

class GoodsDetailScreen extends StatelessWidget {
  final String goodsId;

  const GoodsDetailScreen({super.key, required this.goodsId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<GoodsDetailViewmodel>().getDetailGoods(
        goodsId: goodsId,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final viewModel = context.read<GoodsDetailViewmodel>();
        final item = snapshot.data!;

        return ChangeNotifierProvider(
          create: (_) {
            final vm = GoodsRecommendedViewModel();
            vm.loadRecommendedGoods(goodsId);
            return vm;
          },
          child: Scaffold(
            appBar: CommonAppBar(title: item.name),
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
                        CommonTabsContent(
                          widgets: getTabsDetailWidgets(item.description),
                        ),
                        CommonTabsContent(widgets: getTabsReviewWidgets()),
                        CommonTabsContent(
                          widgets: getTabsDeliveryRefundWidgets(),
                        ),
                        CommonTabsContent(widgets: getTabsInquiryWidgets()),
                      ],
                    ),
                  ),
                ),
                const BottomButtonsWidget(),
              ],
            ),
          )
        );
      },
    );
  }
}

final List<String> tabTitles = ['상세 설명', '리뷰', '배송 & 환불', '문의'];
