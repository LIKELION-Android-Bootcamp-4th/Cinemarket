import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/movies/viewmodel/movies_viewmodel.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/widgets/sort_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinemarket/features/auth/viewmodel/auth_provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});


  @override
  State<MoviesScreen> createState() => MoviesScreenState();
}

class MoviesScreenState extends State<MoviesScreen> {

  final ScrollController _scrollController = ScrollController();
  bool? _prevLogin;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    if (_prevLogin != isLoggedIn) {
      context.read<MoviesViewModel>().loadMovies(force: true);
      _prevLogin = isLoggedIn;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.black,
      color: Colors.white,
      onRefresh: () => context.read<MoviesViewModel>().loadMovies(force: true),
      child: Consumer<MoviesViewModel>(
        builder: (context, vm, child) {
          if (vm.movies.isEmpty && vm.isLoading) {
            return const Center(child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
            ));
          }

          if (vm.errorMessage != null) {
            return const Center(child: Text('영화 데이터를 불러오지 못했습니다. 다시 시도해주세요.',style: AppTextStyle.bodyLarge));
          }

          if (vm.movies.isEmpty) {
            return const Center(child: Text('영화 데이터가 없습니다.',style: AppTextStyle.bodyLarge,));
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
                    showLoadingIndicator: vm.isLoading && vm.hasMore,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}