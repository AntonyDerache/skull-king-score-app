import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/utils/get_player_round_score.dart';
import 'package:skull_king_score_app/src/presentation/utils/supported_locales.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game.dart';
import 'package:skull_king_score_app/src/presentation/views/home/home.dart';
import 'package:skull_king_score_app/src/presentation/views/result/result.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  LanguageState languageCode = const EnglishLanguageState();

  Future<Locale?> _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    String? languageCode = prefs.getString('language_code');
    String? countryCode = prefs.getString('country_code');
    if (languageCode == null || countryCode == null) {
      return null;
    }
    return Locale(languageCode, countryCode);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayerCubit>(create: (_) => PlayerCubit()),
        BlocProvider<LanguageCubit>(create: (_) => LanguageCubit(languageCode)),
        BlocProvider<RoundScoreCubit>(create: (_) => RoundScoreCubit()),
        BlocProvider<GameBloc>(create: (_) => GameBloc()),
      ],
      child: FutureBuilder(
        future: _fetchLocale(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data != null &&
                  snapshot.data!.languageCode == 'fr') {
                context
                    .read<LanguageCubit>()
                    .toggleNewLanguage(snapshot.data!.languageCode);
              }
              break;
            default:
              break;
          }
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return BlocListener<GameBloc, GameState>(
                listenWhen: (previous, current) =>
                    previous.round != current.round,
                listener: (context, state) {
                  if (state.round.getValue() > 0) {
                    context.read<RoundScoreCubit>().setFrom(
                          getPlayerRoundScore(state.round, state.roundHistory),
                        );
                  }
                },
                child: MaterialApp(
                  title: 'Skull King Score Counter',
                  initialRoute: '/',
                  locale: state.locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales:
                      supportedLocales.map((language) => language.locale),
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarBrightness: Brightness.light,
                        statusBarIconBrightness: Brightness.light,
                      ),
                    ),
                  ),
                  routes: {
                    baseUrl: (context) => const Home(),
                    gameUrl: (context) => const Game(),
                    resultUrl: (context) => const Result(),
                  },
                  debugShowCheckedModeBanner: false,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
