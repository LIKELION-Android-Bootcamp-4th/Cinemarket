import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Material(
              color: AppColors.innerWidget,
              child: TabBar(
                tabs: [
                  Tab(child: Text('굿즈', style: TextStyle(fontSize: 20))),
                  Tab(child: Text('영화', style: TextStyle(fontSize: 20))),
                ],
                labelColor: AppColors.textPoint,
                unselectedLabelColor: AppColors.textPrimary,
                indicatorColor: AppColors.textPoint,
              )
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('굿즈 탭 (미구현)')),
                  Center(child: Text('영화 탭 (미구현)')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
