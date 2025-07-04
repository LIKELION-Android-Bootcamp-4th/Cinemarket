import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "검색 결과가 없습니다.\n다른 키워드를 검색해주세요",
        style: TextStyle(color: Colors.white54),
        textAlign: TextAlign.center,
      ),
    );
  }
}