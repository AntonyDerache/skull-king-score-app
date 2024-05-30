import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(LanguageState languageState) : super(languageState);

  Future<void> toggleNewLanguage(LanguageState newState) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newState.languageCode);
    await prefs.setString('country_code', newState.countryCode);
    emit(newState);
  }
}
