import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/home/widgets/recommended_goods_widget.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/common_tab_view.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> dummyGoods = List.generate(10, (i) {
  return {
    'imageUrl': 'https://i.ebayimg.com/images/g/64YAAOSwDqhnttak/s-l1200.png',
    'goodsName': '굿즈 ${i + 1}',
    'movieName': '관련 영화',
    'price': '${(i + 1) * 1000}원',
    'rating': 4.5,
    'reviewCount': 10,
    'isFavorite': false,
  };
});

final List<String> dummyGoodsImages = [
  'https://i.ebayimg.com/images/g/WgwAAOSw~qJnttY4/s-l1200.jpg',
  'https://i.ebayimg.com/images/g/f1oAAOSwq~JnDljW/s-l1200.jpg',
  'https://i.ebayimg.com/images/g/5RMAAOSwhlxnlJl4/s-l400.jpg',
  'https://i.ebayimg.com/images/g/BzAAAeSweMtn22-l/s-l1200.png',
];
final List<String> tabTitles = ['상세 설명', '리뷰', '배송 & 환불', '문의'];

/***
 * 상세 굿즈 통신
 * 이미지들
 *
 ***/
// todo: 새로운 파일로 옮겨야함  // goods/screen
// todo: 상단 앱바의 검색/장바구니 버튼 삭제 (불필요)
// todo: 더미데이터도 그냥 굿즈아이템 객체를 만드는게 더 편하겠는데?
class GoodsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const GoodsDetailScreen({super.key, required Map<String, dynamic> this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: item['goodsName']),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder:
                  (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            PrimaryImageWidget(
                              imageUrl: item['imageUrl'],
                              isFavorite: item['isFavorite'],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dummyGoodsImages.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: SizedBox(
                                      width: 60,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          dummyGoodsImages[index],
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ), // todo: 이미지 짤림?
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rate,
                                      color: Colors.yellow,
                                      size: 16,
                                    ),
                                    Text(
                                      "${item['rating']}",
                                      style: AppTextStyle.bodySmall,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      item['goodsName'],
                                      style: AppTextStyle.section,
                                    ),
                                    Text(
                                      "${item['price']}",
                                      style: AppTextStyle.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
              body: CommonTabView(
                tabTitles: tabTitles,
                tabViews:
                    tabTitles
                        .map((title) => _buildScrollableTabContent(title))  // todo: 실제 탭뷰 코드 필요
                        .toList(),
              ),
            ),
          ),

          // 하단 고정 버튼
          SafeArea(
            top: false,
            child: Container(
              color: AppColors.background,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 24,
                right: 24,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        backgroundColor: AppColors.widgetBackground,
                        textStyle: AppTextStyle.body,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text("장바구니"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        backgroundColor: AppColors.widgetBackground,
                        textStyle: AppTextStyle.body,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text("바로 구매"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildScrollableTabContent(String labelPrefix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("상세 설명 ~", style: AppTextStyle.headline),
        const ExpandableText(
          textWidget: Text('''
『미키17』은 봉준호 감독의 첫 영어 SF 영화로, 동명의 소설 『Mickey7』(에드워드 애슈턴 작)을 원작으로 한다. 

주인공 "미키"는 인류가 새로운 행성에 식민지를 건설하기 위해 파견한 소모성 인물, 일명 "디스포서블"이다. 그는 죽음을 반복하며 자신을 복제해 다시 살아나는 존재다.

죽음의 공포가 일상인 미키는 열일곱 번째로 부활한 클론이다. 하지만 어느 날, 살아있는 전 클론인 "미키16"이 여전히 존재함을 알게 되며 혼란에 빠진다.

이는 시스템에 대한 도전, 존재의 의미에 대한 질문, 그리고 '나는 누구인가'라는 철학적 고민으로 이어진다.

주인공 역할은 로버트 패틴슨이 맡았으며, 나오미 애키, 토니 콜렛, 마크 러팔로 등이 출연한다.

봉준호 감독은 이 작품을 통해 「기생충」 이후 할리우드에서의 새로운 도전을 시도하며, 특유의 사회적 메시지를 SF 장르에 녹여냈다.

'디스포서블'이라는 개념은 현대 사회에서 인간의 도구화, 생명 경시 등의 문제를 투영한 설정으로 평가받고 있다.

미키17은 철저한 관리 체계와 생존 전략 속에서도 인간성이 살아남을 수 있는가를 질문한다.

'복제체'와 '원본'의 관계, 인류의 진보와 그 그림자에 대한 탐구가 핵심 테마다.

영화는 2025년 개봉 예정이며, 전 세계적으로 큰 기대를 받고 있다.

이번 작품은 봉 감독이 직접 각본을 쓰고 연출까지 맡은 프로젝트로, 그의 고유한 스타일이 더욱 깊게 배어있다.

SF 장르 특유의 세계관과 철학적 서사를 동시에 즐기고 싶은 관객에게 강력히 추천되는 작품이다.

예고편에서는 우주선, 외계 행성, 기계화된 인간, 충격적인 복제실 등 시각적으로 압도적인 장면들이 펼쳐진다.

이 작품은 단순한 SF 블록버스터가 아니라, 인간 존재와 정체성의 문제를 던지는 깊이 있는 이야기다.

''', style: AppTextStyle.bodySmall),
        ),


        //----------------------------------- 추천 굿즈 위젯으로 뺄 것
        SizedBox(height: 8,),
        Text('추천 굿즈', style: AppTextStyle.section,),
        SizedBox(height: 8,),
        SizedBox(
          height: 100, // 아이템 높이에 맞춰 적절히 조절
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // ✅ 가로 스크롤
            itemCount: 5,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final item = dummyGoods[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Image.network(
                  'https://i.ebayimg.com/images/g/WgwAAOSw~qJnttY4/s-l1200.jpg',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

//---

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

class ExpandableText extends StatefulWidget {
  final Text textWidget;

  const ExpandableText({super.key, required this.textWidget});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: Text(
            widget.textWidget.data ?? '',
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: widget.textWidget.style,
          ),
          secondChild: SizedBox(
            height: 300, // todo: 하드코딩값 높이
            child: SingleChildScrollView(child: widget.textWidget),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => setState(() => isExpanded = !isExpanded),
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              backgroundColor: AppColors.widgetBackground,
              textStyle: AppTextStyle.body,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Text(
              isExpanded ? '간략히' : '더보기',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
