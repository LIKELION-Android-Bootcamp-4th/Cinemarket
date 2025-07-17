import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../viewmodel/cart_viewmodel.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_empty_view_widgets.dart';
import '../widgets/cart_bottom_bar_widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartViewModel = context.read<CartViewModel>();
      cartViewModel.fetchCart();
      cartViewModel.fetchCartCount();
      cartViewModel.clearSelections();
    });

    return  Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            '장바구니',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Consumer<CartViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final cartItems = viewModel.items;

            final allSelected = cartItems.isNotEmpty && cartItems.every((item) => item.isSelected);

            if (cartItems.isEmpty) {
              return const CartEmptyViewWidgets();
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Checkbox(
                        value: allSelected,
                        onChanged: (value) =>
                            viewModel.toggleSelectAll(value ?? false),
                        activeColor: Colors.black,
                      ),
                      const Text(
                        '전체 선택',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () async {
                          final selectedCartIds = cartItems
                              .where((item) => item.isSelected).map((e) => e.cartId)
                              .toList();
                          if (selectedCartIds.isEmpty) {
                            CommonToast.show(
                              context: context,
                              message: '삭제할 상품이 없습니다.',
                              type: ToastificationType.warning,
                            );
                          } else {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: AppColors.widgetBackground,
                                title: const Text('삼품 삭제', style: AppTextStyle.section,),
                                content: const Text('선택한 상품을 삭제하시겠습니까?', style: AppTextStyle.body,),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('취소', style: AppTextStyle.bodyPointRed,),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('삭제', style: AppTextStyle.bodyPointBlue,),
                                  ),
                                ],
                              ),
                            );
                            if(confirm == true) {
                              await viewModel.removeSelectedItemsFromCart(selectedCartIds);
                              await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: AppColors.widgetBackground,
                                  title: const Text('삭제 완료', style: AppTextStyle.section,),
                                  content: const Text('선택한 상품이 삭제되었습니다.', style: AppTextStyle.body,),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('확인', style: AppTextStyle.bodyPointBlue,),
                                    )
                                  ],
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItemTile(
                        item: item,
                        onChanged: (_) => viewModel.toggleSelect(index),
                        onIncrease: (context) => viewModel.increaseQuantity(index, context),
                        onDecrease: () => viewModel.decreaseQuantity(index),
                      );
                    },
                  ),
                ),

                CartBottomBarWidgets(
                  items: cartItems,
                  onSelectAll: (selectAll) => viewModel.toggleSelectAll(selectAll),
                  onPurchasePressed: () {
                    final selectedItems =
                    viewModel.items.where((item) => item.isSelected).toList();

                    if (selectedItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('선택된 상품이 없습니다')),
                      );
                      return;
                    }

                    context.push('/purchase', extra: selectedItems);
                  },
                ),
              ],
            );
          },
        ),
    );
  }
}