import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_score_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
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
        BlocProvider<RoundBloc>(create: (_) => RoundBloc()),
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
                return MaterialApp(
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
                              statusBarIconBrightness: Brightness.light))),
                  routes: {
                    baseUrl: (context) => const Home(),
                    gameUrl: (contexnt) => const Game(),
                    resultUrl: (contexnt) => const Result(),
                  },
                  debugShowCheckedModeBanner: false,
                );
              },
            );
          }),
    );
  }
}
