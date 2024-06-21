import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';

class GetTotalTricksWon {
  static int execute(List<PlayerRoundScore> roundScoresPlayers) {
    int totalWin = 0;

    for (var playerScore in roundScoresPlayers) {
      totalWin += playerScore.tricksWon;
    }
    return totalWin;
  }
}