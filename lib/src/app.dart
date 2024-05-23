import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_cubit.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game.dart';
import 'package:skull_king_score_app/src/presentation/views/home/home.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Status bar color
        statusBarIconBrightness: Brightness.light));

    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayerCubit>(create: (_) => PlayerCubit()),
        BlocProvider<RoundCubit>(create: (_) => RoundCubit())
      ],
      child: MaterialApp(
        title: 'Skull King Score Counter',
        initialRoute: '/',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light))),
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(builder: (context) => const Home());
          }
          var uri = Uri.parse(settings.name!);
          if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'game') {
            int round = int.parse(uri.pathSegments[1]);
            return MaterialPageRoute(builder: (context) => Game(round: round));
          }
          return MaterialPageRoute(builder: (context) => const Home());
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
