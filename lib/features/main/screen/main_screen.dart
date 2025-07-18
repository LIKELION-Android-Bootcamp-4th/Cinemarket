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
import 'package:provider/provider.dart';
import 'package:cinemarket/features/auth/viewmodel/auth_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  static MainScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<MainScreenState>();

  int _currentIndex = 2; // 홈

  void onTabSelected(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final titles = ['찜 목록', '굿즈', '홈', '영화', '마이페이지'];

        final screens = [
          TickerMode(enabled: _currentIndex == 0, child: const FavoriteScreen()),
          TickerMode(enabled: _currentIndex == 1, child: const GoodsAllScreen()),
          TickerMode(enabled: _currentIndex == 2, child: const HomeScreen()),
          TickerMode(enabled: _currentIndex == 3, child: const MoviesScreen()),
          TickerMode(enabled: _currentIndex == 4, child: const MyPageScreen()),
        ];

        return Scaffold(
          appBar: MainAppBar(
            title: titles[_currentIndex],
            onCartPressed: () => context.push('/cart'),
            onSearchPressed: () => context.push('/search'),
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          backgroundColor: AppColors.background,
          bottomNavigationBar: BottomNavBar(
            currentIndex: _currentIndex,
            onTabSelected: onTabSelected,
          ),
        );
      },
    );
  }
}
