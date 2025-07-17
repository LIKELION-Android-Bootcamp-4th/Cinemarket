import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
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

  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirst) {
      final vm = context.read<GoodsAllViewModel>();
      vm.getAllGoods();

      _isFirst = false;
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final vm = context.read<GoodsAllViewModel>();
        if (vm.hasMore) {
          if (selectedSort == '인기순') {
            vm.getAllGoods(sortBy: 'popular');
          }
          if (selectedSort == '최신순') {
            vm.getAllGoods(sortOrder: 'desc');
          }
          if (selectedSort == '오래된순') {
            vm.getAllGoods(sortOrder: 'asc');
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    if (selectedSort == '인기순') {
      await context.read<GoodsAllViewModel>().getAllGoods(force: true, sortBy: 'popular');
      return;
    }
    if (selectedSort == '최신순') {
      await context.read<GoodsAllViewModel>().getAllGoods(force: true, sortOrder: 'desc');
      return;
    }
    if (selectedSort == '오래된순') {
      await context.read<GoodsAllViewModel>().getAllGoods(force: true, sortOrder: 'asc');
      return;
    }

  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.black,
      color: Colors.white,
      onRefresh: _refresh,
      child: Consumer<GoodsAllViewModel>(
        builder: (context, vm, _) {
          if (vm.goodsList.isEmpty && vm.isLoading) {
            return const Center(child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
            ));
          }
          if (vm.goodsList.isEmpty) {
            return const Center(child: Text('굿즈 준비 중..',style: AppTextStyle.bodyLarge,));
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
                        if (selectedSort == value) return;

                        setState(() {
                          selectedSort = value;
                        });

                        if (selectedSort == '인기순') {
                          vm.getAllGoods(force: true, sortBy: 'popular');
                        }
                        if (selectedSort == '최신순') {
                          vm.getAllGoods(force: true, sortOrder: 'desc');
                        }
                        if (selectedSort == '오래된순') {
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
                    scrollController: _scrollController,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
