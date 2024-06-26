import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(LanguageState languageState) : super(languageState);

  Future<void> toggleNewLanguage(String languageCode) async {
    late LanguageState newState;

    switch (languageCode) {
      case 'en':
        newState = const EnglishLanguageState();
        break;
      case 'fr':
        newState = const FrenchLanguageState();
      default:
        newState = const EnglishLanguageState();
        break;
    }
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newState.locale.languageCode);
    await prefs.setString(
        'country_code', newState.locale.countryCode as String);
    emit(newState);
  }

  Future<void> openRules() async {
    late final Uri url;

    if (state is FrenchLanguageState) {
      url = Uri.parse(urlFrRules);
    } else {
      url = Uri.parse(urlEnRules);
    }
    if (await canLaunchUrl(url) && !await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
