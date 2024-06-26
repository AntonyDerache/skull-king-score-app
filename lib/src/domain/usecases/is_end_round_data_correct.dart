import 'package:skull_king_score_app/src/domain/entities/round.dart';

enum IncorrectDataResult { none, superior, inferior }

class IsEndRoundDataIncorrect {
  static IncorrectDataResult execute(int registeredTricksWon, Round round) {
    if (registeredTricksWon < round.getValue()) {
      return IncorrectDataResult.inferior;
    } else if (registeredTricksWon > round.getValue()) {
      return IncorrectDataResult.superior;
    } else {
      return IncorrectDataResult.none;
    }
  }
}
