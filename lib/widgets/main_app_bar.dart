import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onCartPressed;

  const MainAppBar({super.key, required this.title, this.onSearchPressed, this.onCartPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyle.headline,
      ),
      actions: [
        if (onSearchPressed != null)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearchPressed,
          ),
        if (onCartPressed != null)
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: onCartPressed,
          ),
      ],
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}