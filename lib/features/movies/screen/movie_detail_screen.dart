import 'package:cinemarket/features/movies/widgets/movie_detail_header.dart';
import 'package:cinemarket/features/movies/widgets/movie_info_row.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final String posterUrl = 'https://image.tmdb.org/t/p/original/vqBmyAj0Xm9LnS1xe1MSlMAJyHq.jpg';
    final String thumbnailUrl = 'https://image.tmdb.org/t/p/original/vqBmyAj0Xm9LnS1xe1MSlMAJyHq.jpg';

    final double screenWidth = MediaQuery.of(context).size.width;
    final double posterHeight = screenWidth * 2 / 3;

    final double thumbnailHeight = posterHeight / 2;
    final double thumbnailWidth = thumbnailHeight * 2 / 3;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonAppBar(title: '영화 상세'),
          MovieDetailHeader(
            posterUrl: posterUrl,
            thumbnailUrl: thumbnailUrl,
            isFavorite: isFavorite,
            onFavoriteToggle: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),

          const MovieInfoRow(),
        ],
      ),
    );
  }
}
