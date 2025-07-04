import 'package:cinemarket/widgets/review_item.dart';
import 'package:flutter/material.dart';

// 데이터 모델 클래스
class Review {
  final String productName;
  final String movieTitle;
  final String productImage;
  final double initialRating;
  final String initialReviewText;
  final List<String> photoUrls;

  Review({
    required this.productName,
    required this.movieTitle,
    required this.productImage,
    required this.initialRating,
    required this.initialReviewText,
    required this.photoUrls,
  });
}

class MyReviewComponent extends StatefulWidget {
  const MyReviewComponent({super.key});

  @override
  State<MyReviewComponent> createState() => _MyReviewComponentState();
}

class _MyReviewComponentState extends State<MyReviewComponent> {
  late List<Review> _reviews;

  @override
  void initState() {
    super.initState();
    _reviews = [
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
        productImage: 'https://i.namu.wiki/i/F9cqDEW8kjADTsB9czIdFIRGvOEWgB9Qx3pAEpnvtHzjWcFE7zW-LItvgqB7yRUyfY-mKa5D8HsHoayRIqcUmg.webp',
        initialRating: 4,
        initialReviewText: '전편을 뛰어넘는 속편. 비주얼과 스토리가 정말 완벽했습니다. 다음 편이 너무 기대되네요.',
        photoUrls: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwzcCAWL-xhnoN4VUC4CD5DqJK0ZEzrOKguQ&s'
        ],
      ),
      Review(
        productName: '오펜하이머',
        movieTitle: 'Oppenheimer',
        productImage: 'https://placehold.co/100x100/000000/ffffff?text=Oppen',
        initialRating: 2,
        initialReviewText: '크리스토퍼 놀란 감독의 또 다른 걸작. 몰입감이 엄청나고 배우들의 연기도 훌륭합니다.'
            '크리스토퍼 놀란 감독의 또 다른 걸작. 몰입감이 엄청나고 배우들의 연기도 훌륭합니다.'
            '크리스토퍼 놀란 감독의 또 다른 걸작. 몰입감이 엄청나고 배우들의 연기도 훌륭합니다.'
            '크리스토퍼 놀란 감독의 또 다른 걸작. 몰입감이 엄청나고 배우들의 연기도 훌륭합니다.'
            '크리스토퍼 놀란 감독의 또 다른 걸작. 몰입감이 엄청나고 배우들의 연기도 훌륭합니다.'
            '크리스토퍼 놀란 감독의 또 다른 걸작. 몰입감이 엄청나고 배우들의 연기도 훌륭합니다.'
            '크리스토퍼 놀란 감독의 또 다른 걸작. 몰입감이 엄청나고 배우들의 연기도 훌륭합니다.',
        photoUrls: ['https://placehold.co/60x60/292929/ffffff?text=S3'],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // 상태 변수인 _reviews를 사용하여 목록을 빌드
    return ListView.builder(
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        final review = _reviews[index];
        return ReviewItem(
          productName: review.productName,
          movieTitle: review.movieTitle,
          productImage: review.productImage,
          initialRating: review.initialRating,
          initialReviewText: review.initialReviewText,
          photoUrls: review.photoUrls,
          isEditing: false,
          onClick1: () {
            print('${review.productName} 리뷰 수정');
            // TODO: 실제 수정 로직 구현 (예: 수정 화면으로 이동)
          },
          onClick2: () {
            print('${review.productName} 리뷰 삭제');
            // 삭제 확인 다이얼로그를 띄우는 것이 더 안전한 방법입니다.
            setState(() {
              // 리스트에서 해당 인덱스의 리뷰를 제거하고 화면을 다시 그림
              _reviews.removeAt(index);
            });
          },
        );
      },
    );
  }
}
