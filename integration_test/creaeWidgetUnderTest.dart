import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget createWidgetUnderTest(Widget homeWidget) {
  return MaterialApp(
    title: 'Skull King Score Counter',
    locale: const EnglishLanguageState().locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: homeWidget,
  );
}
