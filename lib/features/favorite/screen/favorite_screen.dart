import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        color: AppColors.background,
        child: const Column(
          children: [
            Material(
              color: AppColors.widgetBackground,
              child: TabBar(
                tabs: [
                  // Tab(child: Text('굿즈', style: TextStyle(fontSize: 20))),
                  Tab(child: Text('영화', style: TextStyle(fontSize: 20))),
                  Tab(child: Text('굿즈', style: AppTextStyle.headline)),  // todo: 커스텀 색상 사용 시 라벨 적용 안댐
                  // Tab(child: Text('영화', style: AppTextStyle.headline)),
                ],
                labelColor: AppColors.textPoint,
                unselectedLabelColor: AppColors.textPrimary,
                indicatorColor: AppColors.innerWidget,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TabBarView(
                  children: [
                    Center(child: Text('영화 탭 (미구현)')),
                    Center(child: Text('영화 탭 (미구현)')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
