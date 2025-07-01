import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: '검색하기'),
      body: const Center(
        child: Text('검색 화면 입니다'),
      ),
    );
  }
}
