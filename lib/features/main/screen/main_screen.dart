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

//
// class MainScreen extends StatelessWidget {
//   final Widget child;
//
//   const MainScreen({super.key, required this.child});
//
//   static const List<String> _tabs = [
//     '/wishlist',
//     '/goods',
//     '/home',
//     '/movieslist',
//     '/mypage',
//   ];
//
//   static const Map<String, String> _tabTitles = {
//     '/wishlist': '찜 목록',
//     '/goods': '굿즈',
//     '/home': '홈',
//     '/movieslist': '영화',
//     '/mypage': '마이페이지',
//   };
//
//   int _calculateSelectedIndex(BuildContext context) {
//     final location = GoRouterState.of(context).uri.toString();
//     final index = _tabs.indexWhere((path) => location.startsWith(path));
//     return index < 0 ? 2 : index;
//   }
//
//   String _getTitle(BuildContext context) {
//     final location = GoRouterState.of(context).uri.toString();
//     final matched = _tabTitles.entries.firstWhere(
//           (entry) => location.startsWith(entry.key),
//       orElse: () => const MapEntry('/home', '홈'),
//     );
//     return matched.value;
//   }
//
//   void _onTabSelected(BuildContext context, int index) {
//     if (index >= 0 && index < _tabs.length) {
//       context.go(_tabs[index]);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final selectedIndex = _calculateSelectedIndex(context);
//
//     return Scaffold(
//       appBar: MainAppBar(
//           title: _getTitle(context),
//           onCartPressed: () => context.push('/cart'),
//           onSearchPressed: () => context.push('/search'),
//       ),
//       body: child,
//       backgroundColor: AppColors.background,
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: selectedIndex,
//         onTabSelected: (index) => _onTabSelected(context, index),
//       ),
//     );
//   }
// }
//

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
