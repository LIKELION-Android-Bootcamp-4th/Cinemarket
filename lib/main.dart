import 'package:cinemarket/features/auth/viewmodel/auth_provider.dart';
import 'package:cinemarket/features/auth/viewmodel/my_page_viewmodel.dart';
import 'package:cinemarket/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:cinemarket/features/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_review_viewmodel.dart';
import 'package:cinemarket/features/home/viewmodel/best_goods_viewmodel.dart';
import 'package:cinemarket/features/home/viewmodel/best_movie_viewmodel.dart';
import 'package:cinemarket/features/purchase/viewmodel/purchase_viewmodel.dart';
import 'package:cinemarket/features/search/viewmodel/search_view_model.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_all_viewmodel.dart';
import 'package:cinemarket/features/movies/viewmodel/movies_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:cinemarket/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinemarket/core/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => GoodsAllViewModel()),
        ChangeNotifierProvider(create: (_) => MoviesViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => MyPageViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()..fetchCartCount()),
        ChangeNotifierProvider(create: (_) => FavoriteViewModel()),
        ChangeNotifierProvider(create: (_) => GoodsReviewsViewModel()),
        ChangeNotifierProvider(create: (_) => BestGoodsViewModel()),
        ChangeNotifierProvider(create: (_) => BestMovieViewModel()),
        ChangeNotifierProvider(create: (_) => PurchaseViewModel()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),

      ],
      child: MaterialApp.router(
        title: 'CineMarket',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
