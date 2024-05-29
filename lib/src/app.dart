import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_score_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game.dart';
import 'package:skull_king_score_app/src/presentation/views/home/home.dart';
import 'package:skull_king_score_app/src/presentation/views/result/result.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayerCubit>(create: (_) => PlayerCubit()),
        BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
        BlocProvider<RoundScoreCubit>(create: (_) => RoundScoreCubit()),
        BlocProvider<RoundBloc>(create: (_) => RoundBloc()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Skull King Score Counter',
            initialRoute: '/',
            locale: Locale.fromSubtags(languageCode: state.code),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('fr'),
            ],
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarBrightness: Brightness.light,
                        statusBarIconBrightness: Brightness.light))),
            routes: {
              baseUrl: (context) => const Home(),
              gameUrl: (contexnt) => const Game(),
              resultUrl: (contexnt) => const Result(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
