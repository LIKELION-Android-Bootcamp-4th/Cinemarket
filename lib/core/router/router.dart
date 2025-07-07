import 'package:cinemarket/features/cart/screen/cart_screen.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/features/favorite/screen/favorite_screen.dart';
import 'package:cinemarket/features/goods/screen/goods_detail_screen.dart';
import 'package:cinemarket/features/goods/screen/goods_screen.dart';
import 'package:cinemarket/features/goods/screen/review/goods_review_screen.dart';
import 'package:cinemarket/features/home/screen/home_screen.dart';
import 'package:cinemarket/features/login/screen/login_screen.dart';
import 'package:cinemarket/features/main/screen/main_screen.dart';
import 'package:cinemarket/features/movies/screen/movie_detail_screen.dart';
import 'package:cinemarket/features/movies/screen/movies_screen.dart';
import 'package:cinemarket/features/mypage/detail/component/fix_review_component.dart';
import 'package:cinemarket/features/mypage/detail/my_page_detail_screen.dart';
import 'package:cinemarket/features/mypage/screen/my_page_screen.dart';
import 'package:cinemarket/features/purchase/screen/purchase_screen.dart';
import 'package:cinemarket/features/search/screen/search_screen.dart';
import 'package:cinemarket/features/signup/screen/sign_up_screen.dart';
import 'package:go_router/go_router.dart';


final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/wishlist',
          builder: (context, state) => const FavoriteScreen(),
        ),
        GoRoute(
          path: '/goods',
          builder: (context, state) => const GoodsScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/movies',
          builder: (context, state) => const MoviesScreen(),
        ),
        GoRoute(
          path: '/mypage',
          builder: (context, state) => const MyPageScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen()
    ),
    GoRoute(
      path: '/goods/detail',
      builder: (context, state) {
        final item = state.extra as Map<String, dynamic>;
        return GoodsDetailScreen(item: item);
      },
    ),
    GoRoute(
      path: '/movies/:movieId',
      builder: (context, state) {
        final movieId = state.pathParameters['movieId']!;
        return MovieDetailScreen(movieId: movieId);
      },
    ),
    GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen()
    ),
    GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignUpScreen()
    ),
    GoRoute(
        path: '/goods/detail/review',
      builder: (context, state) => const GoodsReviewScreen(),
    ),
    GoRoute(
      path: '/mypage/detail',
      builder: (context, state) => const MyPageDetailScreen(),
    ),
    GoRoute(
      path: '/widget',
      builder: (context, state) => const FixReviewComponent(),
    ),
    GoRoute(
      path: '/purchase',
      builder: (context, state) {
        final cartItems = state.extra as List<CartItem>;
        return PurchaseScreen(cartItems: cartItems);
      },
    ),
  ],
);
