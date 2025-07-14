import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/cart/service/cart_service.dart';
import 'package:cinemarket/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class BottomButtonsWidget extends StatelessWidget {
  final Goods item;

  const BottomButtonsWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final cartService = CartService();

    return SafeArea(
      top: false,
      child: Container(
        color: AppColors.background,
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Row(
          children: [

            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final isLoggedIn = await TokenStorage.isLoggedIn();
                  if (!isLoggedIn) {
                    CommonToast.show(
                      context: context,
                      message: '로그인이 필요합니다.',
                      type: ToastificationType.warning,
                    );
                    return;
                  }
                  try {
                    await cartService.addItemToCart(
                      productId: item.id,
                      quantity: 1,
                      unitPrice: item.price,
                    );
                    context.read<CartViewModel>().fetchCartCount();
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
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  backgroundColor: AppColors.widgetBackground,
                  textStyle: AppTextStyle.body,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text("장바구니"),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final isLoggedIn = await TokenStorage.isLoggedIn();
                  if (!isLoggedIn) {
                    CommonToast.show(
                      context: context,
                      message: '로그인이 필요합니다.',
                      type: ToastificationType.warning,
                    );
                    return;
                  }
                  try {
                    // 1. 장바구니에 임시 추가
                    await cartService.addItemToCart(
                      productId: item.id,
                      quantity: 1,
                      unitPrice: item.price,
                    );

                    // 2. 장바구니 최신 목록 불러오기
                    final allItems = await cartService.fetchCartItems();

                    // 3. 해당 productId의 cartItem 찾기
                    final match = allItems.firstWhere(
                          (e) => e.productId == item.id,
                      orElse: () => throw Exception('장바구니에 상품이 없습니다.'),
                    );

                    // 4. CartItem 변환해서 구매화면으로 이동
                    final cartItem = CartItem(
                      cartId: match.cartId,
                      productId: match.productId,
                      name: match.name,
                      quantity: match.quantity,
                      price: match.price,
                      stock: match.stock,
                      imageUrl: match.image,
                      isSelected: true,
                    );

                    context.push('/purchase', extra: [cartItem]);
                  } catch (e) {
                    CommonToast.show(
                      context: context,
                      message: '바로구매 실패: ${e.toString()}',
                      type: ToastificationType.error,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  backgroundColor: AppColors.widgetBackground,
                  textStyle: AppTextStyle.body,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text("바로 구매"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
