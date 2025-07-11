import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/model/order/order_item.dart';
import 'package:cinemarket/features/mypage/viewmodel/order_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class OrderHistoryWidget extends StatelessWidget {
  const OrderHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = OrderViewModel();
        vm.fetchOrders();
        return vm;
      },
      child: Consumer<OrderViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(child: Text('에러: ${vm.errorMessage}'));
          }

          if (vm.orders.isEmpty) {
            return const Center(child: Text('주문 내역이 없습니다.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: vm.orders.length,
            itemBuilder: (context, index) {
              final order = vm.orders[index];
              final item = order.items.isNotEmpty ? order.items.first : null;

              if (item == null) return const SizedBox();

              return _buildOrderItemCard(context, order.createdAt, order.status, item, order.id);
            },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(color: Color(0xFF292929), thickness: 2),
              )
          );
        },
      )
    );
  }

  Widget _buildOrderItemCard(BuildContext context, DateTime createdAt, String status, dynamic item, String orderId) {
    final dateStr = '${createdAt.year}.${createdAt.month.toString().padLeft(2, '0')}.${createdAt.day.toString().padLeft(2, '0')}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 날짜 + 주문상세
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(dateStr, style: AppTextStyle.section),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () {
                        context.push('/mypage/detail', extra: {
                          'where': 'order_detail',
                          'orderId': orderId,
                        });
                      },
                      child: Text("주문상세", style: AppTextStyle.body),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(status, style: AppTextStyle.bodySmall),
              ],
            )
          ],
        ),
        const SizedBox(height: 16.0),

        // 상품 이미지 + 정보
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF292929),
                borderRadius: BorderRadius.circular(8),
                image: item.productImage != null
                    ? DecorationImage(
                  image: NetworkImage(item.productImage),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.productName ?? '상품명 없음', style: AppTextStyle.body),
                  const SizedBox(height: 8),
                  Text('${item.quantity}개', style: AppTextStyle.bodySmall),
                  const SizedBox(height: 4),
                  Text('${item.totalPrice}원', style: AppTextStyle.bodySmall),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // 버튼들
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: item.review != null ? null :() {
                  // // 리뷰 작성 화면 이동
                  // context.push('/mypage/detail', extra: {'where': 'fix_review'});
                  context.push('/mypage/create-review', extra: item);
                },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.grey.shade600; // 비활성화일 때 회색
                        }
                        return AppColors.textPoint; // 활성화일 때 색상
                      },
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                child: Text(
                  item.review != null ? '리뷰 완료' : '리뷰 쓰기',
                )
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final productId = item.productId?.id ?? '';
                  if (productId.isNotEmpty) {
                    context.push('/goods/$productId');
                  } else {
                    CommonToast.show(context: context, message: '상품 정보가 없습니다.',type: ToastificationType.info);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pointAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('재구매'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
