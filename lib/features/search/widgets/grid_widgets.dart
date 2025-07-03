import 'package:cinemarket/features/search/widgets/item_box_widgets.dart';
import 'package:flutter/material.dart';

class ResultGrid extends StatelessWidget {
  final String label;
  final List<Map<String, String>> items;

  const ResultGrid({super.key, required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.75,
      children: items.map((item) {
        final map = item as Map<String, String>;

        return ItemBox(
          label: label,
          title: map['title']?? '제목 없음',
          imageUrl: map['image']?? '',
          subText: label == '굿즈' ? '| 24,000' : '조회수 2만회',
        );
      }) .toList()
    );
  }
}