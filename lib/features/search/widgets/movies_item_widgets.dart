import 'package:flutter/material.dart';

class MoviesItem extends StatelessWidget {
  const MoviesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text('영화', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}