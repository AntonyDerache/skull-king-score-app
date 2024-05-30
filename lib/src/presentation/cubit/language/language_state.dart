class LanguageState {
  String languageCode;
  String countryCode;

  LanguageState(this.languageCode, this.countryCode);

  @override
  String toString() {
    return 'languageCode: $languageCode ; countryCode: $countryCode';
  }
}

class FrenchLanguageState extends LanguageState {
  FrenchLanguageState() : super('fr', 'FR');
}

class EnglishLanguageState extends LanguageState {
  EnglishLanguageState() : super('en', 'US');
}
