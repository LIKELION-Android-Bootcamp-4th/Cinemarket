import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/viewmodel/order_status_viewmodel.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OrderTrackingWidget extends StatefulWidget {
  const OrderTrackingWidget({super.key});

  @override
  State<OrderTrackingWidget> createState() => _OrderTrackingWidgetState();
}

class _OrderTrackingWidgetState extends State<OrderTrackingWidget> {
  String? selectedOrderId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderStatusViewModel>(
      create: (_) => OrderStatusViewModel()..loadTrackingOrders(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: const CommonAppBar(title: '배송 조회'),
        body: Consumer<OrderStatusViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.errorMessage != null) {
              return Center(child: Text(vm.errorMessage!, style: AppTextStyle.body));
            }

            final orders = vm.trackingOrders;
            final selectedOrder = orders.firstWhere(
                  (o) => o.id == selectedOrderId,
              orElse: () =>orders.first
            );
            selectedOrderId ??= selectedOrder.id;

            return Column(
              children: [
                _buildOrderStatusHeader(selectedOrder),
                const Divider(color: AppColors.widgetBackground),
                Expanded(child: _buildOrderListView(orders)),
              ],
            );
          },
        ),
      ),
    );
  }


  Widget _buildOrderStatusHeader(Order order) {
    final steps = ['pending', 'confirmed', 'preparing', 'shipped', 'delivered'];
    final labels = ['주문 접수', '주문 확정', '상품 준비 중', '배송 시작', '배송 완료'];
    final currentStep = steps.indexOf(order.status);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        children: [
          // 1. 원 + 선
          Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isEven) {
                final stepIndex = index ~/ 2;
                final isActive = stepIndex <= currentStep;
                return CircleAvatar(
                  radius: 10,
                  backgroundColor: isActive ? AppColors.pointAccent : AppColors.widgetBackground,
                );
              } else {
                final lineIndex = index ~/ 2;
                final isActive = lineIndex < currentStep;
                return Expanded(
                  child: Container(
                    height: 2,
                    color: isActive ? AppColors.pointAccent : AppColors.widgetBackground,
                  ),
                );
              }
            }),
          ),
          const SizedBox(height: 8),
          // 2. 텍스트 라벨
          Row(
            children: List.generate(steps.length, (index) {
              return Expanded(
                child: Text(
                  labels[index],
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: index <= currentStep ? Colors.white : Colors.grey,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }



  Widget _buildOrderListView(List<Order> orders) {
    return ListView.builder(
      itemCount: orders.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final order = orders[index];
        final isSelected = selectedOrderId == order.id;

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOrderId = order.id;
                });
              },
              child: Card(
                color: isSelected ? AppColors.widgetBackground : Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 0),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDate(order.createdAt), style: AppTextStyle.bodyLarge,),
                          TextButton(
                            onPressed: () {
                              context.push('/mypage/detail', extra: {
                                'where': 'order_detail',
                                'orderId': order.id,
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              '주문 상세',
                              style: AppTextStyle.bodySmall
                            ),
                          ),
                        ],
                      )
                      ,
                      const SizedBox(height: 6),
                      Text('주문번호: ${order.orderNumber}', style: AppTextStyle.bodySmall),
                      const SizedBox(height: 12),
                      ...order.items.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.productImage ?? '',
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.productName,
                                style: AppTextStyle.body,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('x${item.quantity}', style: AppTextStyle.bodySmall),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            // 주문 간 Divider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(color: AppColors.widgetBackground, thickness: 1),
            ),
          ],
        );

      },
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.day.toString().padLeft(2, '0')}';
  }
}
