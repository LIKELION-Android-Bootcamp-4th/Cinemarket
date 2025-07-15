import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/detail/widget/order_card.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/viewmodel/order_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class OrderHistoryWidget extends StatelessWidget {
  const OrderHistoryWidget({super.key});

  String formatCurrency(int price) {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(price)}원';
  }

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
            return const Center(child: Text('주문 내역을 받아오지 못했습니다.',style: AppTextStyle.bodyLarge));
          }

          if (vm.orders.isEmpty) {
            return const Center(child: Text('주문 내역이 없습니다.',style: AppTextStyle.bodyLarge));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: vm.orders.length,
            itemBuilder: (context, index) {
              final order = vm.orders[index];
              return OrderCard(order: order, formatCurrency: formatCurrency);
            },
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
            ),
          );
        },
      ),
    );
  }

}


