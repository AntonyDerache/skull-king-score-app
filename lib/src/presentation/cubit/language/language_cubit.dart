import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState('en'));

  void toggleNewLanguage(String code) {
    emit(LanguageState(code));
  }
}
