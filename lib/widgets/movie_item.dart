import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatefulWidget {
  final String imageUrl;
  final String movieName;
  final int cumulativeSales;
  final List<String> providers;
  final bool isFavorite;

  const MovieItem({
    super.key,
    required this.imageUrl,
    required this.movieName,
    required this.cumulativeSales,
    required this.providers,
    required this.isFavorite,
  });

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.widgetBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() => isFavorite = !isFavorite);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.movieName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.body,
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: [
                const Icon(
                  Icons.trending_up,
                  size: 14,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: 4),
                Text('${widget.cumulativeSales}', style: AppTextStyle.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4,),
            child: Row(
              children:
                  widget.providers.map((imageUrl) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 4,),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(imageUrl, width: 15, height: 15),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
