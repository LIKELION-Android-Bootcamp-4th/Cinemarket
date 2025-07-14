import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
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

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<MoviesViewModel>();
      vm.loadMovies();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        final vm = context.read<MoviesViewModel>();
        if (!vm.isLoading && vm.hasMore) {
          vm.loadMovies();
        }
      }
    });

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<MoviesViewModel>().loadMovies(force: true),
      child: Consumer<MoviesViewModel>(
        builder: (context, vm, child) {
          if (vm.movies.isEmpty && vm.isLoading) {
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
                    onSelected: (sortTypeLabel) {
                      vm.changeSortTypeFromLabel(sortTypeLabel);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: CommonGridview(
                    itemType: ItemType.movie,
                    items: movies,
                    scrollController: _scrollController,
                  ),
                ),
                if (vm.isLoading && vm.hasMore)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                // 더 이상 불러올 데이터가 없을 때 메시지 표시
                if (!vm.hasMore && vm.movies.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('더 이상 불러올 영화가 없습니다.',style: AppTextStyle.body,)),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}