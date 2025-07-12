import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class CartBottomBarWidgets extends StatelessWidget {
  final List<CartItem> items;
  final ValueChanged<bool> onSelectAll;
  final void Function()? onPurchasePressed;

  const CartBottomBarWidgets({
    Key? key,
    required this.items,
    required this.onSelectAll,
    this.onPurchasePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //선택된 굿즈 수량
    int total = items
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.price * item.quantity);
    //선택된 굿즈 총 금액
    int selectedCount = items
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.quantity);

    return SafeArea(
      top: false,
      child: Container(
        color: AppColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 체크박스 / 텍스트
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Checkbox(
                    value: items.any((item) => item.isSelected),
                    onChanged: (value) => onSelectAll(value!),
                    activeColor: Colors.black,
                  ),
                  const SizedBox(width: 4),
                  Expanded( //
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '합계 $selectedCount개',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${total.toString().replaceAllMapped(
                            RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},',)}원',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 4),

            //결제 버튼
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedCount > 0) {
                      final selectedItems = items.where((item) => item.isSelected).toList();
                      context.push('/purchase', extra: selectedItems); //데이터 전달
                    } else {
                      CommonToast.show(
                        context: context,
                        message: '선택된 상품이 없습니다.',
                        type: ToastificationType.warning,
                        placement: ToastPlacement.bottom,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pointAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '결제하기',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
