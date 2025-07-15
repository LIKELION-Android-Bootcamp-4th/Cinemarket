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
import 'package:cinemarket/features/mypage/service/review_service.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/common_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoodsDetailScreen extends StatelessWidget {
  final String goodsId;

  const GoodsDetailScreen({super.key, required this.goodsId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoodsDetailViewmodel>(
      create: (_) => GoodsDetailViewmodel()..getDetailGoods(goodsId: goodsId),
      child: Consumer<GoodsDetailViewmodel>(
        builder: (context, vm, _) {
          final item = vm.goods;

          if (item == null) {
            return const Scaffold(
              backgroundColor: AppColors.background,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return ChangeNotifierProvider(
            create: (_) {
              final recommendedVM = GoodsRecommendedViewModel();
              recommendedVM.loadRecommendedGoods(goodsId);
              return recommendedVM;
            },
            child: Scaffold(
              appBar: CommonAppBar(title: item.name),
              backgroundColor: AppColors.background,
              body: Column(
                children: [
                  Expanded(
                    child: NestedScrollView(
                      headerSliverBuilder: (context, _) => [
                        HeaderGoodsDetail(item: item),
                      ],
                      body: CommonTabView(
                        tabTitles: tabTitles,
                        tabViews: [
                          CommonTabsContent(
                            widgets: getTabsDetailWidgets(item.description),
                          ),
                          CommonTabsContent(
                            widgets: [
                              FutureBuilder<String>(
                                future: ReviewService()
                                    .fetchContentIdByProductId(goodsId)
                                    .then((id) {
                                  if (id == null) return '';
                                  return ReviewService()
                                      .fetchMovieTitleByContentId(id)
                                      .then((title) => title ?? '');
                                }),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  }

                                  final movieTitle = snapshot.data!;
                                  return getTabsReviewWidget(
                                    context: context,
                                    goodsId: goodsId,
                                    goodsName: item.name,
                                    movieTitle: movieTitle,
                                    goodsImage: item.images.main,
                                  );
                                },
                              ),
                            ],
                          ),
                          CommonTabsContent(
                            widgets: getTabsDeliveryRefundWidgets(),
                          ),
                          CommonTabsContent(
                            widgets: getTabsInquiryWidgets(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BottomButtonsWidget(item: item),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<String> tabTitles = ['상세 설명', '리뷰', '배송&환불', '문의'];
