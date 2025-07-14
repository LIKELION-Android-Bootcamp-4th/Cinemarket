import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';

class PrimaryImageWidget extends StatefulWidget {
  final String goodsId;
  final String imageUrl;
  final bool isFavorite;
  final void Function() onTap;

  const PrimaryImageWidget({
    super.key,
    required this.goodsId,
    required this.imageUrl,
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
            toggleFavorite(context: context,
                id: widget.goodsId,
                isFavorite: isFavorite,
                onStateChanged: (newState) {
                  setState(() => isFavorite = newState);
                });
          },
        ),
      ],
    );
  }
}
