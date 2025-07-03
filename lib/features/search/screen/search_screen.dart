import 'package:cinemarket/features/search/widgets/grid_widgets.dart';
import 'package:cinemarket/features/search/widgets/search_field_widgets.dart';
import 'package:cinemarket/features/search/widgets/search_result_widgets.dart';
import 'package:cinemarket/features/search/widgets/section_title_widgets.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String keyword = '';
  bool hasSearched = false;

  final dummyGoods = <Map<String, String>>[
    {
      'title' : '아이언맨 피규어',
      'image' : 'https://img4.tmon.kr/cdn3/deals/2019/11/09/2687495970/front_beea5_g1fgn.png',
    },
    {
      'title' : '아이언맨 스마트폰 케이스',
    },
    {
      'title' : '어벤져스 피규어',
    },
    {
      'title' : '캡티 아메리카 텀블러'
    },
  ];
  final dummyMovies = <Map<String, String>>[
    {
      'title' : '아이언맨1',
      'image' : 'https://i.namu.wiki/i/GfTPJRwpWhsAsxaUTxBRYI8vLSZr06T3roet7iM-9GKRWPQhxNt712gV24CdnaiWnmjn-ravxLO6_GwWsyghUQ.webp'
    },
    {
      'title' : '아이언맨2',
    },
    {
    'title' : '아이언맨3',
    },
    {
      'title' : '어벤져스',
    },
    {
    'title' : '캡틴 아메리카'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final GoodsResults = dummyGoods.where((p) => p['title']!.toLowerCase().contains(keyword.toLowerCase())).toList();
    final movieResults = dummyMovies.where((m) => m['title']!.toLowerCase().contains(keyword.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 검색창
            SearchField(
              controller: _controller,
              onChanged: (val) {
                setState(() {
                  keyword = val;
                  hasSearched = val.trim().isNotEmpty;
                });
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle("굿즈"),
                    const SizedBox(height: 12),

                    if (!hasSearched) ...[
                      const SearchResult(),
                    ] else if (GoodsResults.isEmpty) ...[
                      const SearchResult(),
                    ] else ...[
                      ResultGrid(label: "굿즈", items: GoodsResults),
                    ],

                    const SizedBox(height: 32),

                    const SectionTitle("영화"),
                    const SizedBox(height: 12),

                    if (!hasSearched) ...[
                      const SearchResult(),
                    ] else if (movieResults.isEmpty) ...[
                      const SearchResult(),
                    ] else ...[
                      ResultGrid(label: "영화", items: movieResults),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}