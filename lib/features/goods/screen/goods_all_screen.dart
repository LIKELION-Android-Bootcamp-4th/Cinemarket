import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_all_viewmodel.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/widgets/sort_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoodsAllScreen extends StatefulWidget {
  const GoodsAllScreen({super.key});

  @override
  State<GoodsAllScreen> createState() => _GoodsAllScreenState();
}

class _GoodsAllScreenState extends State<GoodsAllScreen> {
  bool _isFirst = true;
  String selectedSort = '최신순';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirst) {
      final vm = context.read<GoodsAllViewModel>();
      if (!vm.isLoaded) {
        vm.getAllGoods();
      }
      _isFirst = false;
    }
  }

  Future<void> _refresh() async {
    await context.read<GoodsAllViewModel>().getAllGoods(force: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Consumer<GoodsAllViewModel>(
          builder: (context, vm, _) {
            if (!vm.isLoaded || vm.goodsList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SortDropdown(
                        itemType: ItemType.goods,
                        selectedValue: selectedSort,
                        onSelected: (value) {
                          setState(() {
                            selectedSort = value;
                          });

                          if (value == '인기순') {
                            vm.getAllGoods(force: true, sortBy: 'popular');
                          }
                          if (value == '최신순') {
                            vm.getAllGoods(force: true, sortOrder: 'desc');
                          }
                          if (value == '오래된순') {
                            vm.getAllGoods(force: true, sortOrder: 'asc');
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: CommonGridview<Goods>(
                      itemType: ItemType.goods,
                      items: vm.goodsList,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
