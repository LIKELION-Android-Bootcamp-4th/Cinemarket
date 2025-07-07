import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/mypage/detail/component/my_review_component.dart' show Review;
import 'package:cinemarket/widgets/review_item.dart';
import 'package:flutter/material.dart';

/***
 * 좋아요 순 또는 최신순으로 10개만 리뷰 가져오기
 * UI는 기존 리뷰 목록과 동일하지만 하단의 좋아요/싫어요 버튼만 제거
 */
List<Widget> getTabsReviewWidgets() {
  return[
    const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('리뷰', style: AppTextStyle.headline),
        Spacer(),
        Text('더보기', style: AppTextStyle.point,)
      ],
    ),
    ...List.generate(
    10, (_) => _reviews.map(
      (review) => ReviewItem(
        productName: review.productName,
        movieTitle: review.movieTitle,
        productImage: review.productImage,
        photoUrls: review.photoUrls,
        initialRating: review.initialRating,
        initialReviewText: review.initialReviewText,
      ),
    ),
  ).expand((e) => e),
  ];
}

List<Review> _reviews = [
  Review(
    productName: '존 윅 4',
    movieTitle: 'John Wick: Chapter 4',
    productImage:
        'https://i.namu.wiki/i/NdikfqD9ep_gcMtGFO8Yn1aDyW17YTS5a85qrYiKsnGD_cOudNNV34xJTuVYXvG3ci6eD0Bko8m1Qmep0VWuOg.webp',
    initialRating: 5.0,
    initialReviewText:
        '액션이 정말 역대급입니다. 키아누 리브스는 늙지도 않네요. 처음부터 끝까지 눈을 뗄 수가 없었습니다. 강렬한 액션을 원하신다면 꼭 보세요!',
    photoUrls: [
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
      'https://www.chosun.com/resizer/v2/WZNZSQFOJBBVHGMMLIW3G6VOVY.jpg?auth=fecf0fda94e45389c73e77a19b63d0d795c468b8f95f5b2656f1e1d58741902a&width=616',
      'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTBfMjUy/MDAxNjgxMDk4MDY5MTY4.RjIYmuwdXuhNK5n4GBfmHyKvqnspm3E_-TaDHv7xFm0g.kWEjcHbcgCfp8Aq0gEpJJc8LCKxdffPZOhj9yvZaDIAg.JPEG.realnogun/3456435345.jpg?type=w800',
    ],
  ),
  Review(
    productName: '스파이더맨: 어크로스 더 유니버스',
    movieTitle: 'Spider-Man: Across the Spider-Verse',
    productImage:
        'https://i.namu.wiki/i/F9cqDEW8kjADTsB9czIdFIRGvOEWgB9Qx3pAEpnvtHzjWcFE7zW-LItvgqB7yRUyfY-mKa5D8HsHoayRIqcUmg.webp',
    initialRating: 4,
    initialReviewText: '전편을 뛰어넘는 속편. 비주얼과 스토리가 정말 완벽했습니다. 다음 편이 너무 기대되네요.',
    photoUrls: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwzcCAWL-xhnoN4VUC4CD5DqJK0ZEzrOKguQ&s',
    ],
  ),
];
