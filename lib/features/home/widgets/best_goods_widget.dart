import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';

class BestGoodsWidget extends StatelessWidget {
  const BestGoodsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final dummyGoods = [
      const GoodsItem(
        imageUrl: 'https://contents.kyobobook.co.kr/sih/fit-in/400x0/gift/pdt/1334/S1718960797739.jpg',
        goodsName: '인사이드 아웃 2 인형',
        movieName: '인사이드 아웃 2',
        price: '₩25,000',
        rating: 4.8,
        reviewCount: 321,
        isFavorite: false,
      ),
      const GoodsItem(
        imageUrl: 'https://common.image.cf.marpple.co/files/u_193535/2022/4/original/4048906ed44e46814282dba3c13625a7167d53201.png?q=92&w=1480&f=jpeg&bg=f6f6f6',
        goodsName: '혹성탈출 고릴라 티셔츠',
        movieName: '혹성탈출: 새로운 시대',
        price: '₩34,000',
        rating: 4.2,
        reviewCount: 210,
        isFavorite: true,
      ),
      const GoodsItem(
        imageUrl: 'https://bananagreen.co.kr/cdn/shop/files/2617493794777552_1302661906_e89b898f-1e80-4d98-9d9c-b0eb8235ea8a.png?v=1719472993&width=1946',
        goodsName: '퓨리오사 피규어',
        movieName: '퓨리오사',
        price: '₩69,000',
        rating: 4.9,
        reviewCount: 105,
        isFavorite: false,
      ),
      const GoodsItem(
        imageUrl: 'https://img.extmovie.com/files/attach/images/135/433/138/092/03806748248afa18f3952ccb830e1e6b.jpg',
        goodsName: '범죄도시 4 굿즈',
        movieName: '범죄도시 4',
        price: '₩19,800',
        rating: 4.3,
        reviewCount: 88,
        isFavorite: false,
      ),
      const GoodsItem(
        imageUrl: 'https://eseltree.com/data/shopimages/multi/00_091001015000000386.jpg',
        goodsName: '조이 에코백',
        movieName: '인사이드 아웃 2',
        price: '₩21,500',
        rating: 4.6,
        reviewCount: 145,
        isFavorite: true,
      ),
    ];

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
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: dummyGoods.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 140,
                  child: dummyGoods[index],
                );
              },
            ),
          ),

        ],
    );
  }
}
