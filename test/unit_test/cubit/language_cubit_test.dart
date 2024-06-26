import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group(LanguageCubit, () {
    test('Language Cubit initial state is correct', () {
      // GIVEN
      LanguageState initialLanguage = const EnglishLanguageState();
      // WHEN
      LanguageCubit languageCubit = LanguageCubit(initialLanguage);
      // THEN
      expect(
        languageCubit.state,
        isA<EnglishLanguageState>()
            .having(
              (language) => language.locale,
              "locale",
              const Locale('en', 'US'),
            )
            .having(
              (language) => language.flagPath,
              "flagPath",
              enFlagPath,
            ),
      );
    });

    group('toggleNewLanguage', () {
      const LanguageState enLanguageState = EnglishLanguageState();
      const LanguageState frLanguageState = FrenchLanguageState();
      SharedPreferences.setMockInitialValues({});

      blocTest<LanguageCubit, LanguageState>(
        "emits FrenchLanguageState when toggleNewLanguage is called with fr languageCode",
        // GIVEN
        build: () => LanguageCubit(enLanguageState),
        // WHEN
        act: (bloc) {
          bloc.toggleNewLanguage('fr');
        },
        // THEN
        expect: () => [
          isA<FrenchLanguageState>()
              .having(
                (language) => language.locale,
                "locale",
                const Locale('fr', 'FR'),
              )
              .having(
                (language) => language.flagPath,
                "flagPath",
                frFlagPath,
              ),
        ],
      );
      blocTest<LanguageCubit, LanguageState>(
        "emits EnglishLanguageState when toggleNewLanguage is called with en languageCode",
        // GIVEN
        build: () => LanguageCubit(frLanguageState),
        // WHEN
        act: (bloc) {
          bloc.toggleNewLanguage('en');
        },
        // THEN
        expect: () => [isA<EnglishLanguageState>()],
      );
      blocTest<LanguageCubit, LanguageState>(
        "emits EnglishLanguageState when toggleNewLanguage is called with unknown languageCode",
        build: () => LanguageCubit(frLanguageState),
        // WHEN
        act: (bloc) {
          bloc.toggleNewLanguage('uk');
        },
        // THEN
        expect: () => [isA<EnglishLanguageState>()],
      );
    });
  });
}
