import 'package:skull_king_score_app/src/domain/entities/round.dart';

class IsEndRoundDataCorrect {
  static bool call(int registeredTricksWon, Round round) =>
      registeredTricksWon < round.getValue();
}
