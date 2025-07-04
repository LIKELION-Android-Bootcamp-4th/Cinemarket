import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

typedef OnTabSelected = void Function(int index);

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final OnTabSelected onTabSelected;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.background,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Color(0xffD32F2F),
      unselectedItemColor: Colors.white,
      onTap: onTabSelected,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: '찜'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '굿즈'),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: '영화'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이'),
      ],
    );
  }
}
