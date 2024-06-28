import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';

List<PlayerRoundScore> getPlayerRoundScore(
    Round round, List<List<PlayerRoundScore>> roundHistory) {
  return roundHistory[round.getValue() - 1]
      .map((item) => PlayerRoundScore.clone(item))
      .toList();
}
