import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/viewmodel/order_detail_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class OrderDetailWidget extends StatelessWidget {
  final String orderId;

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(amount)}원';
  }

  String getStatusLabel(String status) {
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
        return '구매 확정';
      case 'cancelled':
        return '주문 취소';
      case 'refunded':
        return '환불 완료';
      default:
        return status;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'preparing':
      case 'shipped':
        return Colors.green;
      case 'delivered':
      case 'confirmed':
        return Colors.blue;
      case 'cancelled':
      case 'refunded':
        return Colors.red;
      default:
        return Colors.white;
    }
  }


  const OrderDetailWidget({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderDetailViewModel>(
        create: (_) {
          final vm = OrderDetailViewModel();
          vm.fetchOrderDetail(orderId);
          return vm;
        },
      child: Consumer<OrderDetailViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(child: Text('에러: ${vm.errorMessage}'));
          }

          final order = vm.orderDetail;
          if (order == null) {
            return const Center(child: Text('주문 정보가 없습니다.'));
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDateInfo(order),
                      const Divider(thickness: 1, color: AppColors.widgetBackground),
                      _buildDeliveryInfo(order),
                      const Divider(thickness: 1, color: AppColors.widgetBackground),
                      _buildGoodsInfo(context,order),
                      const Divider(thickness: 1, color: AppColors.widgetBackground),
                      _buildPaymentInfo(order),
                      const Divider(thickness: 1, color: AppColors.widgetBackground),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: AppColors.widgetBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("돌아가기", style: AppTextStyle.section),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );

  }


  Widget _buildPaymentInfo(order) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('결제 정보', style: AppTextStyle.section),
          const SizedBox(height: 16),

          // 각 아이템 별 금액
          ...order.items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${item.productName}',style: AppTextStyle.bodyLarge,),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${formatCurrency(item.unitPrice)}', style: AppTextStyle.body),
                    Row(
                      children: [
                        Text('x ${item.quantity}', style: AppTextStyle.body),
                        SizedBox(width: 10,),
                        Text(formatCurrency(item.totalPrice), style: AppTextStyle.body),
                      ],
                    )
                  ],
                ),
                Divider(thickness: 1,color: AppColors.widgetBackground,)
              ],
            )
          )),


          // 배송비
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('배송비', style: AppTextStyle.bodyLarge),
              Text(formatCurrency(order.shippingCost), style: AppTextStyle.body),
            ],
          ),

          const Divider(thickness: 1, color: AppColors.widgetBackground),

          // 총 결제 금액
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('총 결제 금액', style: AppTextStyle.bodyLarge),
              Text(formatCurrency(order.totalAmount), style: AppTextStyle.section),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildGoodsInfo(BuildContext context, order) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("주문 정보", style: AppTextStyle.section),
          const SizedBox(height: 16),
          ...order.items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF292929),
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(item.productImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.productName, style: AppTextStyle.body),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('${formatCurrency(item.unitPrice)}', style: AppTextStyle.bodySmall),
                              SizedBox(width: 10,),
                              Text('x ${item.quantity}', style: AppTextStyle.bodySmall),
                            ]
                          ),
                          Text('${formatCurrency(item.totalPrice)}', style: AppTextStyle.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final productId = item.productId ?? '';
                      if (productId.isNotEmpty) {
                        GoRouter.of(context).push('/goods/$productId');
                      } else {
                        CommonToast.show(
                          context: context,
                          message: '상품 정보가 없습니다.',
                          type: ToastificationType.error,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.widgetBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text("재구매", style: AppTextStyle.body),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }


  Widget _buildDeliveryInfo(order) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주문자 정보', style: AppTextStyle.section),
          SizedBox(height: 20,),
          Text(order.shippingInfo.recipient ?? '이름 없음', style: AppTextStyle.section),
          const SizedBox(height: 10),
          Text(order.shippingInfo.address ?? '주소 없음', style: AppTextStyle.body),
          Text(order.shippingInfo.phone ?? '(연락처 없음)', style: AppTextStyle.bodySmall),
        ],
      ),
    );
  }

  Widget _buildDateInfo(order) {
    final dateStr = order.createdAt.toString().substring(0, 10);
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dateStr, style: AppTextStyle.section),
              Text('주문번호 : ${order.orderNumber}', style: AppTextStyle.body),
            ],
          ),
          Text(getStatusLabel(order.status), style: AppTextStyle.body.copyWith(color: getStatusColor(order.status))),
        ],
      ),
    );
  }
}
