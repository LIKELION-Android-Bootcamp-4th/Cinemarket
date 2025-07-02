import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BestGoodsWidget extends StatelessWidget {
  const BestGoodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '베스트 굿즈',
                  style: AppTextStyle.headline,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      '더보기',
                      style: TextStyle(color: Colors.grey),
                    )
                )
              ]
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // dummy 5개
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return const SampleCard(label: '굿즈');
              },
            ),
          ),
        ],
    );
  }
}

class SampleCard extends StatelessWidget {
  const SampleCard({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
