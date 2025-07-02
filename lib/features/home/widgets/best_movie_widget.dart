import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/home/widgets/best_goods_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BestMovieWidget extends StatelessWidget {
  const BestMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '베스트 영화',
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
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => const SampleCard(label: '영화'),
            ),
          ),
        ],
      );
  }
}