import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_all_viewmodel.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/widgets/sort_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoodsScreen extends StatelessWidget {
  const GoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, dynamic>> dummyGoods = List.generate(10, (i) {
    //   return {
    //     'imageUrl':
    //         'https://i.ebayimg.com/images/g/BzAAAeSweMtn22-l/s-l1200.png',
    //     'goodsName': '굿즈 ${i + 1}',
    //     'movieName': '관련 영화',
    //     'price': '${(i + 1) * 1000}원',
    //     'rating': 4.5,
    //     'reviewCount': 10,
    //     'isFavorite': false,
    //   };
    // });

    final viewModel = context.watch<GoodsAllViewModel>();
    viewModel.getAllGoods();

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
            child: CommonGridview(
              itemType: ItemType.goods,
              items: viewModel.goodsList,
            ),
          ),
        ],
      ),
    );
  }
}
