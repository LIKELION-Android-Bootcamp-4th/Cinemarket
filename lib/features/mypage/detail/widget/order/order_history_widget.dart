import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/detail/widget/order/viewModel/order_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class OrderItem {
  final String date;
  final String status;
  final String productName;
  final String movieTitle;
  final String? productImage;
  final String quantity;
  final String price;
  final String reviewStatus;

  OrderItem({
    required this.date,
    required this.status,
    required this.productName,
    required this.movieTitle,
    this.productImage,
    required this.quantity,
    required this.price,
    required this.reviewStatus,
  });
}

class OrderHistoryWidget extends StatefulWidget {
  const OrderHistoryWidget({super.key});

  @override
  State<OrderHistoryWidget> createState() => _OrderHistoryWidgetState();
}

class _OrderHistoryWidgetState extends State<OrderHistoryWidget> {
  late List<OrderItem> _orders;
  OrderViewModel _viewModel = OrderViewModel();
  @override
  void initState() {
    super.initState();
    _viewModel.fetchOrders(
      page: 1,
      limit: 20,
      status: 'delivered',
      startDate: '2025-01-01',
      endDate: '2025-12-31',
      sort: 'createdAt',
      order: 'desc',
    );

    _orders = [
      OrderItem(
        date: '25.06.25',
        status: '구매 확정',
        productName: '제품명',
        movieTitle: '영화명',
        productImage: 'https://placehold.co/100x100/292929/ffffff?text=Product',
        quantity: '??개',
        price: '??,???원',
        reviewStatus: '리뷰완료',
      )
    ];
  }

  void _deleteOrder(int index) {

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Color(0xFF292929),
          title: Text(
            '리뷰삭제',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          content: Text(
            "리뷰를 삭제 하시겠습니까?",
            style: TextStyle(color: Colors.white70, fontSize: 18.0),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text(
                      '유지하기',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text(
                      '삭제하기',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      //todo 삭제 API
                      setState(() {
                        _orders.removeAt(index);
                      });
                      // TODO: 서버에도 삭제하는 통신 추가

                      CommonToast.show(
                        context: context,
                        message: "주문 내역이 삭제되었습니다.",
                        type: ToastificationType.success,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return _buildOrderItemCard(order, index);
      },
      separatorBuilder:
          (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(color: Color(0xFF292929), thickness: 2),
          ),
    );
  }

  Widget _buildOrderItemCard(OrderItem order, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(order.date, style: AppTextStyle.section),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () {
                        context.push('/mypage/detail', extra: 'order_detail');
                      },
                      child: Text("주문상세", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(order.status, style: AppTextStyle.bodySmall),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white54),
              onPressed: () => _deleteOrder(index),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF292929),
                borderRadius: BorderRadius.circular(8),
                image:
                    order.productImage != null
                        ? DecorationImage(
                          image: NetworkImage(order.productImage!),
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
                  Text(order.productName, style: AppTextStyle.body),
                  const SizedBox(height: 4),
                  Text(order.movieTitle, style: AppTextStyle.bodySmall),
                  const SizedBox(height: 8),
                  Text(order.quantity, style: AppTextStyle.bodySmall),
                  const SizedBox(height: 4),
                  Text(order.price, style: AppTextStyle.bodySmall),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if(order.reviewStatus == '리뷰쓰기') {
                    context.push(
                      '/mypage/detail',
                      extra: {'where': 'fix_review',},
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      order.reviewStatus == '리뷰완료'
                          ? AppColors.widgetBackground
                          : AppColors.textPoint,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(order.reviewStatus),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 재구매 로직 추가
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pointAccent,
                  foregroundColor: Colors.white,
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
