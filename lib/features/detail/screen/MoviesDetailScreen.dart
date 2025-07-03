import 'package:flutter/material.dart';

class MoviesDetailScreen extends StatelessWidget {
  const MoviesDetailScreen({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('영화 상세 화면'),
      ),
    );
  }
}