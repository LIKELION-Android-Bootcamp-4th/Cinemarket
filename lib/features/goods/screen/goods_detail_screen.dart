import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/cart/model/cart_item_model.dart';
import 'package:cinemarket/features/goods/services/goods_cart_service.dart';
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
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

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
                        CommonTabsContent(
                        widgets: [
                          FutureBuilder<String>(
                            future: ReviewService()
                                .fetchContentIdByProductId(goodsId)
                                .then((id) {
                              if (id == null) return '';
                              return ReviewService().fetchMovieTitleByContentId(id)
                              .then((title) => title ?? '');
                            }),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox(); // 또는 로딩 위젯
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
                        CommonTabsContent(widgets: getTabsInquiryWidgets()),
                      ],
                    ),
                  ),
                ),
                BottomButtonsWidget(
                  goods: item,
                  onAddToCart: () async {
                    try {
                      await context.read<GoodsDetailViewmodel>().addToCartFromGoods(item);

                      CommonToast.show(
                        context: context,
                        message: '장바구니에 추가되었습니다.',
                        type: ToastificationType.success,
                      );
                    } catch (e) {
                      CommonToast.show(
                        context: context,
                        message: '장바구니 추가 실패',
                        type: ToastificationType.error,
                      );
                    }
                  },
                  onBuyNow: () {
                    final tempCartItem = CartItemModel(
                      cartId: '',
                      productId: item.id,
                      name: item.name,
                      description: item.description,
                      price: item.price,
                      stock: item.stock,
                      quantity: 1,
                      image: item.images.main,
                    );

                    context.push('/purchase', extra: [tempCartItem]);
                  },
                ),
              ],
            ),
          )
        );
      },
    );
  }
}

final List<String> tabTitles = ['상세 설명', '리뷰', '배송 & 환불', '문의'];
