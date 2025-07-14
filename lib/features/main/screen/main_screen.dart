import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/favorite/screen/favorite_screen.dart';
import 'package:cinemarket/features/goods/screen/goods_all_screen.dart';
import 'package:cinemarket/features/home/screen/home_screen.dart';
import 'package:cinemarket/features/movies/screen/movies_screen.dart';
import 'package:cinemarket/features/mypage/screen/my_page_screen.dart';
import 'package:cinemarket/widgets/bottom_nav_bar.dart';
import 'package:cinemarket/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2; // 홈

  final List<Widget> _screens = const [
    FavoriteScreen(),
    GoodsAllScreen(),
    HomeScreen(),
    MoviesScreen(),
    MyPageScreen(),
  ];

  void _onTabSelected(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['찜 목록', '굿즈', '홈', '영화', '마이페이지'];

    return Scaffold(
      appBar: MainAppBar(
        title: titles[_currentIndex],
        onCartPressed: () => context.push('/cart'),
        onSearchPressed: () => context.push('/search'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
