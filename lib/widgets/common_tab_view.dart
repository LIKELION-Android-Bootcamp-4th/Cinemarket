import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_colors.dart';

class CommonTabView extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabViews;

  const CommonTabView({
    super.key,
    required this.tabTitles,
    required this.tabViews,
  }) : assert(tabTitles.length == tabViews.length, '탭과 뷰의 개수는 같아야 합니다.');

  double _getFontSizeByTabCount(int count) {
    if (count == 4) return 14;
    if (count == 3) return 16;
    return 18;
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = _getFontSizeByTabCount(tabTitles.length);

    return DefaultTabController(
      length: tabTitles.length,
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            Material(
              color: AppColors.widgetBackground,
              child: TabBar(
                tabs: tabTitles
                    .map((title) => Tab(
                    child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                        )
                    )
                ))
                    .toList(),
                labelColor: AppColors.textPoint,
                unselectedLabelColor: AppColors.textPrimary,
                indicatorColor: AppColors.innerWidget,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.5,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TabBarView(children: tabViews),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
