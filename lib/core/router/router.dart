import 'package:cinemarket/features/cart/screen/cart_screen.dart';
import 'package:cinemarket/features/cart/widgets/cart_item_widgets.dart';
import 'package:cinemarket/features/favorite/screen/favorite_screen.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/screen/goods_detail_screen.dart';
import 'package:cinemarket/features/goods/screen/goods_all_screen.dart';
import 'package:cinemarket/features/goods/screen/goods_review_screen.dart';
import 'package:cinemarket/features/home/screen/home_screen.dart';
import 'package:cinemarket/features/login/screen/login_screen.dart';
import 'package:cinemarket/features/main/screen/main_screen.dart';
import 'package:cinemarket/features/movies/screen/movie_detail_screen.dart';
import 'package:cinemarket/features/movies/screen/movies_screen.dart';
import 'package:cinemarket/features/mypage/detail/widget/create_review_widget.dart';
import 'package:cinemarket/features/mypage/detail/widget/fix_review_widget.dart';
import 'package:cinemarket/features/mypage/detail/my_page_detail_screen.dart';
import 'package:cinemarket/features/mypage/model/order/order_item.dart';
import 'package:cinemarket/features/mypage/model/orderdetail/order_detail_item.dart';
import 'package:cinemarket/features/mypage/model/review.dart';
import 'package:cinemarket/features/mypage/screen/my_page_screen.dart';
import 'package:cinemarket/features/purchase/screen/purchase_screen.dart';
import 'package:cinemarket/features/search/screen/search_screen.dart';
import 'package:cinemarket/features/signup/screen/sign_up_screen.dart';
import 'package:go_router/go_router.dart';


final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
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
      path: '/goods/:goodsId',
      builder: (context, state) {
        final goodsId = state.pathParameters['goodsId']!;
        return GoodsDetailScreen(goodsId: goodsId,);
      },
    ),
    GoRoute(
      path: '/goods/:goodsId/review',
      builder: (context, state) {
        final goodsId = state.pathParameters['goodsId']!;

        final extra = state.extra as Map<String, dynamic>?;

        final goodsName = extra?['goodsName'] as String?;
        final movieTitle = extra?['movieTitle'] as String?;
        final goodsImage = extra?['goodsImage'] as String?;

        return GoodsReviewScreen(
          goodsId: goodsId,
          goodsName: goodsName ?? '',
          movieTitle: movieTitle ?? '',
          goodsImage: goodsImage ?? '',
        );
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
      path: '/mypage/detail',
      builder: (context, state) => const MyPageDetailScreen(),
    ),
    GoRoute(
      path: '/widget',
      builder: (context, state) {
        final review = state.extra as Review;
        return FixReviewWidget(review: review);
      }
    ),
    GoRoute(
      path: '/purchase',
      builder: (context, state) {
        final cartItems = state.extra as List<CartItem>;
        return PurchaseScreen(cartItems: cartItems);
      },
    ),
    GoRoute(
      path: '/mypage/create-review',
      builder: (context, state) {
        final orderItem = state.extra as OrderDetailItem;
        return CreateReviewWidget(orderItem: orderItem);
      },
    ),

  ],
);
