import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/model/order/order_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class OrderCard extends StatefulWidget {
  final Order order;
  final String Function(int) formatCurrency;

  const OrderCard({
    super.key,
    required this.order,
    required this.formatCurrency,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> with TickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final dateStr = '${order.createdAt.year}.${order.createdAt.month.toString().padLeft(2, '0')}.${order.createdAt.day.toString().padLeft(2, '0')}';
    final visibleItems = _expanded ? order.items : order.items.take(1).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: Card(
            color: AppColors.cardBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            elevation: 2,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dateStr, style: AppTextStyle.section),
                      TextButton(
                        onPressed: () {
                          context.push('/mypage/detail', extra: {
                            'where': 'order_detail',
                            'orderId': order.id,
                          });
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text('주문상세', style: AppTextStyle.body.copyWith(color: AppColors.textPoint)),
                      ),
                    ],
                  ),
                  Text(
                    _getStatusLabel(order.status),
                    style: AppTextStyle.body.copyWith(
                      color: _getStatusColor(order.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('주문번호: ${order.orderNumber}', style: AppTextStyle.body),
                  const Divider(thickness: 1, color: AppColors.innerWidget),
                  Text('주문 상품', style: AppTextStyle.section),
                  const SizedBox(height: 20),

                  ...visibleItems.map((item) => _buildOrderItem(context, item)),
                ],
              ),
            ),
          ),
        ),

        if (order.items.length > 1)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardBackground
          ),
          child: TextButton.icon(
            onPressed: () {
              setState(() => _expanded = !_expanded);
            },
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more,color: AppColors.textPoint,),
            label: Text(
              _expanded ? '간략히 보기' : '${order.items.length - 1}개 더 보기',
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem(BuildContext context, OrderItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.productImage ?? '',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: AppColors.widgetBackground,
                    child: const Icon(Icons.image_not_supported, color: AppColors.innerWidget),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.productName ?? '상품명 없음', style: AppTextStyle.bodyLarge),
                    const SizedBox(height: 4),
                    Text('${item.quantity}개', style: AppTextStyle.body),
                    const SizedBox(height: 2),
                    Text(widget.formatCurrency(item.totalPrice), style: AppTextStyle.body),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

String _getStatusLabel(String status) {
  switch (status) {
    case 'pending':
      return '주문 접수';
    case 'preparing':
      return '상품 준비 중';
    case 'shipped':
      return '배송 시작';
    case 'delivered':
      return '배송 완료';
    case 'confirmed':
      return '주문 확정';
    case 'cancelled':
      return '주문 취소';
    case 'refunded':
      return '환불 완료';
    default:
      return status;
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'preparing':
    case 'shipped':
    case 'confirmed':
      return Colors.green;
    case 'delivered':
      return Colors.blue;
    case 'cancelled':
    case 'refunded':
      return Colors.red;
    default:
      return Colors.white;
  }
}
