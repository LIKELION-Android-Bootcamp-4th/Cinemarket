import 'package:cinemarket/features/movies/model/cast_member.dart';
import 'package:cinemarket/features/movies/widgets/cast_item.dart';
import 'package:flutter/material.dart';

class CastGridView extends StatelessWidget {
  final List<CastMember> castList;

  const CastGridView({super.key, required this.castList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: castList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final cast = castList[index];
        return CastItem(
          imageUrl: 'https://image.tmdb.org/t/p/w500${cast.profilePath}',
          name: cast.name,
          character: cast.character,
        );
      },
    );
  }
}
