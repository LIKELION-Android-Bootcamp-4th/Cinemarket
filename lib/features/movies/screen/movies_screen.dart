import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/features/movies/viewmodel/movies_viewmodel.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/widgets/sort_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});


  @override
  State<MoviesScreen> createState() => MoviesScreenState();
}

class MoviesScreenState extends State<MoviesScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<MoviesViewModel>();
      vm.loadMovies();
    });

  }

  @override
  Widget build(BuildContext context) {

    return Consumer<MoviesViewModel>(
      builder: (context, vm, child) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.errorMessage != null) {
          return Center(child: Text('에러 발생: ${vm.errorMessage}'));
        }

        if (vm.movies.isEmpty) {
          return const Center(child: Text('영화 데이터가 없습니다.'));
        }

        final movies = vm.movies;
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SortDropdown(
                  itemType: ItemType.movie,
                  selectedValue: vm.sortType.label,
                  onSelected: (sortType) {
                    if (sortType == '최신순') {
                      vm.changeSortTypeFromLabel('최신순');
                    } else if (sortType == '평점순') {
                      vm.changeSortTypeFromLabel('평점순');
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: CommonGridview(
                  itemType: ItemType.movie,
                  items: vm.movies.map((movie) {
                    return {
                      'imageUrl': 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      'movieName': movie.title,
                      'cumulativeSales': 0,
                      'providers': <String>[],
                      'isFavorite': false,
                    };
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
