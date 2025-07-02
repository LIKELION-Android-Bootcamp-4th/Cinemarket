import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class GoodsItem extends StatefulWidget {
  final String imageUrl;
  final String goodsName;
  final String movieName;
  final String price;
  final double rating;
  final int reviewCount;
  final bool isFavorite;

  const GoodsItem({
    super.key,
    required this.imageUrl,
    required this.goodsName,
    required this.movieName,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.isFavorite,
  });

  @override
  State<GoodsItem> createState() => _GoodsItemState();
}

class _GoodsItemState extends State<GoodsItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() => isFavorite = !isFavorite);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              widget.goodsName,
              style: AppTextStyle.body,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              widget.movieName,
              style: AppTextStyle.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Icon(Icons.star_rate, size: 15, color: Colors.yellow,),
                Text('${widget.rating}(${widget.reviewCount})',
                style: AppTextStyle.bodySmall,),
                Spacer(),
                Text(
                  widget.price,
                  style: AppTextStyle.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
