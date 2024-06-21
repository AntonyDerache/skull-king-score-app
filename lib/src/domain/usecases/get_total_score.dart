import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/calcul_round_score.dart';

class GetTotalScore {
  static int execute(Round round, PlayerRoundScore playerRoundScore) {
    return playerRoundScore.currentScore +
        CalculRoundScore.execute(round, playerRoundScore);
  }
}
