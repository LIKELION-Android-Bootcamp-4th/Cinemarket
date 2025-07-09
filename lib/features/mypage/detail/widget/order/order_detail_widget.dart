import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class OrderDetailWidget extends StatefulWidget {
  const OrderDetailWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrderDetailWidgetState();
  }
}

class _OrderDetailWidgetState extends State<OrderDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDateInfo(),
              Divider(
                height: 5.0,
                thickness: 5.0,
                color: AppColors.widgetBackground,
              ),
              _buildDeliveryInfo(),
              Divider(
                height: 5.0,
                thickness: 5.0,
                color: AppColors.widgetBackground,
              ),
              _buildGoodsInfo(),
              Divider(
                height: 5.0,
                thickness: 5.0,
                color: AppColors.widgetBackground,
              ),
              _buildPaymentInfo(),
              Divider(
                height: 5.0,
                thickness: 5.0,
                color: AppColors.widgetBackground,
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () {
                    //todo
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: AppColors.widgetBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    )
                  ),
                  child: Text("돌아가기", style: AppTextStyle.section),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("결제 정보", style: AppTextStyle.section),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("상품 금액", style: AppTextStyle.body),
              Text("goods price", style: AppTextStyle.body),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("수량", style: AppTextStyle.body),
              Text("x1", style: AppTextStyle.body),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("총 금액", style: AppTextStyle.body),
              Text("all price", style: AppTextStyle.body),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoodsInfo() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("주문 정보", style: AppTextStyle.section),
          SizedBox(height: 16),
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
                    image: NetworkImage(
                      "https://m.mondayfactory.co.kr/web/product/medium/202102/80c8c3a9df86659f7390f4f3e4ead588.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("커스텀 굿즈", style: AppTextStyle.body),
                        Text(
                          "이 굿즈는 커스텀으로 생성된 굿즈입니다.이 굿즈는 커스텀으로 생성된 굿즈입니다.이 굿즈는 커스텀으로 생성된 굿즈입니다.",
                          style: AppTextStyle.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    print("상품정보 클릭");
                    //todo 상품정보 페이지 이동
                  },
                  child: Text("상품정보", style: AppTextStyle.bodySmallLink),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                //todo 재구매
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
    );
  }

  Widget _buildDeliveryInfo() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("아이디", style: AppTextStyle.section),
          SizedBox(height: 16),
          Text("주소지", style: AppTextStyle.body),
          Text("(연락처)", style: AppTextStyle.bodySmall),
        ],
      ),
    );
  }

  Widget _buildDateInfo() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1999.99.99", style: AppTextStyle.section),
              Text("주문번호 : ", style: AppTextStyle.body),
            ],
          ),
          Spacer(),
          Text("구매 상태", style: AppTextStyle.body),
        ],
      ),
    );
  }
}
