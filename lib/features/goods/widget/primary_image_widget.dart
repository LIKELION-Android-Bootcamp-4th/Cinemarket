import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';

class PrimaryImageWidget extends StatefulWidget {
  final String goodsId;
  final String imageUrl;
  final int stock;
  final bool isFavorite;
  final void Function() onTap;

  const PrimaryImageWidget({
    super.key,
    required this.goodsId,
    required this.imageUrl,
    required this.stock,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  State<PrimaryImageWidget> createState() => _PrimaryImageWidgetState();
}

class _PrimaryImageWidgetState extends State<PrimaryImageWidget> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(widget.imageUrl, fit: BoxFit.cover),
          ),
        ),

        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            toggleFavorite(
              context: context,
              id: widget.goodsId,
              isFavorite: isFavorite,
              onStateChanged: (newState) {
                setState(() => isFavorite = newState);
              },
            );
          },
        ),

        if (widget.stock == 0) ...[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.only(left: 4, right: 4, bottom: 2),
              child: const Text('품절', style: AppTextStyle.bodyLarge),
            ),
          ),
        ],
      ],
    );
  }
}
