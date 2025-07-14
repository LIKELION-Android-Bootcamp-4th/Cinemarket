import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CastItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String character;

  const CastItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            // borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150,
                  height: 150,
                  color: AppColors.widgetBackground,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.person,
                    size: 80,
                    color: AppColors.innerWidget,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: AppTextStyle.section,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            character,
            style: AppTextStyle.body,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          )
        ],
      )
    );
  }
}
