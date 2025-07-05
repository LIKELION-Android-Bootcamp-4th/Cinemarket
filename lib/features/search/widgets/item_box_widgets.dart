import 'package:cinemarket/features/detail/screen/GoodsDetailScreen.dart';
import 'package:cinemarket/features/detail/screen/MoviesDetailScreen.dart';
import 'package:flutter/material.dart';

class ItemBox extends StatefulWidget {
  final String label; // 상품 or 영화
  final String title;
  final String? subText; // 가격 or 누적 판매량
  final String imageUrl; //이미지 추가

  const ItemBox({
    super.key,
    required this.label,
    required this.title,
    required this.imageUrl,
    this.subText,
  });

  @override
  State<StatefulWidget> createState() => _ItemBoxState();

}

class _ItemBoxState extends State<ItemBox> {
  bool isWishedLocal = false;

  void _goToDetail(BuildContext context) {
    if (widget.label == '굿즈') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => GoodsDetailScreen(title: widget.title),
      //   ),
      // );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MoviesDetailScreen(title: widget.title),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF292929),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 틀 + 찜 버튼
          Stack(
            children: [
              GestureDetector(
                onTap: () => _goToDetail(context),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isWishedLocal = !isWishedLocal;
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: isWishedLocal ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 제목
          Text(
            widget.title,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),

        ],
      ),
    );
  }
}