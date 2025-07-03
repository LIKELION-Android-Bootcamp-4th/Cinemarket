import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/widgets/bottom_nav_bar.dart';
import 'package:cinemarket/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  static const List<String> _tabs = [
    '/wishlist',
    '/goods',
    '/home',
    '/movies',
    '/mypage',
  ];

  static const Map<String, String> _tabTitles = {
    '/wishlist': '찜 목록',
    '/goods': '굿즈',
    '/home': '홈',
    '/movies': '영화',
    '/mypage': '마이페이지',
  };

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _tabs.indexWhere((path) => location.startsWith(path));
    return index < 0 ? 2 : index;
  }

  String _getTitle(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final matched = _tabTitles.entries.firstWhere(
          (entry) => location.startsWith(entry.key),
      orElse: () => const MapEntry('/home', '홈'),
    );
    return matched.value;
  }

  void _onTabSelected(BuildContext context, int index) {
    if (index >= 0 && index < _tabs.length) {
      context.go(_tabs[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      appBar: MainAppBar(
          title: _getTitle(context),
          onCartPressed: () => context.push('/cart'),
          onSearchPressed: () => context.push('/search'),
      ),
      body: child,
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavBar(
        currentIndex: selectedIndex,
        onTabSelected: (index) => _onTabSelected(context, index),
      ),
    );
  }
}

