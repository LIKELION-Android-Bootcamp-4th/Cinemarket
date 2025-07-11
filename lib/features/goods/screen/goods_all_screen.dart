import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_all_viewmodel.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/widgets/sort_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoodsAllScreen extends StatelessWidget {
  const GoodsAllScreen({super.key});

  Future<void> _refresh(BuildContext context) async {
    await context.read<GoodsAllViewModel>().getAllGoods(force: true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<GoodsAllViewModel>().getAllGoods(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final viewModel = context.read<GoodsAllViewModel>();

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: SortDropdown(itemType: ItemType.goods),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: CommonGridview<Goods>(
                  itemType: ItemType.goods,
                  items: viewModel.goodsList,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
