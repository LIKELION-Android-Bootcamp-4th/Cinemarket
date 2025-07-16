import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/home/viewmodel/best_goods_viewmodel.dart';
import 'package:cinemarket/features/main/screen/main_screen.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BestGoodsWidget extends StatelessWidget {
  const BestGoodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = BestGoodsViewModel();
        vm.loadBestGoods();
        return vm;
      },
      child: Consumer<BestGoodsViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
            ));
          }
          if (vm.errorMessage != null) {
            return Center(child: Text(vm.errorMessage!,style: AppTextStyle.body,));
          }
          if (vm.goodsList.isEmpty) return const Text("상품이 없습니다.");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '베스트 굿즈',
                      style: AppTextStyle.headline,
                    ),
                    TextButton(
                        onPressed: () {
                          final mainState = MainScreenState.of(context);
                          mainState?.onTabSelected(1);
                        },
                        child: const Text(
                          '굿즈 더보기',
                            style: AppTextStyle.point
                        )
                    )
                  ]
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.goodsList.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final goods = vm.goodsList[index];
                    final movieName = vm.movieTitleMap[goods.id] ?? '불러오는 중입니다..';
                    return GestureDetector(
                      onTap: () {
                        context.push('/goods/${goods.id}');
                      },
                      child: SizedBox(
                        width: 150,
                        child: GoodsItem(
                          goodsId: goods.id,
                          imageUrl: goods.images.main,
                          goodsName: goods.name,
                          movieTitle: movieName,
                          price: goods.price,
                          stock: goods.stock,
                          rating: goods.reviewStats.averageRating,
                          reviewCount: goods.reviewCount,
                          isFavorite: goods.isFavorite,
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          );

        }
      ),
    );

  }
}
