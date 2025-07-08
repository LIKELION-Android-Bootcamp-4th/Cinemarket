import 'package:cinemarket/features/movies/viewmodel/movies_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:cinemarket/features/home/viewModel/home_viewmodel.dart';
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
          ChangeNotifierProvider(create: (_) => MoviesViewModel()),
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: MaterialApp.router(
        title: 'CineMarket',
        routerConfig: router,
      )
    );
  }
}
