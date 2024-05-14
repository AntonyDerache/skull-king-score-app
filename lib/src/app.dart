import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/cubits/player/player_cubit.dart';
import 'package:skull_king_score_app/src/views/game/game.dart';
import 'package:skull_king_score_app/src/views/home/home.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayerCubit(),
      child: MaterialApp(
        title: 'Skull King Score Counter',
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
          '/game': (context) => const Game(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
