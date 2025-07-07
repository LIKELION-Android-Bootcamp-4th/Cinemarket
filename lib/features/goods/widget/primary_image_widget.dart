import 'package:flutter/material.dart';

class PrimaryImageWidget extends StatefulWidget {
  final String imageUrl;
  final bool isFavorite;

  const PrimaryImageWidget({
    super.key,
    required this.imageUrl,
    required this.isFavorite,
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
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(widget.imageUrl, fit: BoxFit.cover),
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
    );
  }
}