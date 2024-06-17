import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';

class LanguageState extends Equatable {
  final Locale locale;
  final String? flagPath;

  const LanguageState(this.locale, this.flagPath);

  @override
  String toString() {
    return 'languageCode: ${locale.languageCode} ; countryCode: ${locale.countryCode}';
  }

  @override
  List<Object?> get props => [locale];
}

final class FrenchLanguageState extends LanguageState {
  const FrenchLanguageState() : super(const Locale('fr', 'FR'), frFlagPath);
}

final class EnglishLanguageState extends LanguageState {
  const EnglishLanguageState() : super(const Locale('en', 'US'), enFlagPath);
}
