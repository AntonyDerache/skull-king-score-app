import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';

class CalculRoundScore {
  static int execute(Round round, PlayerRoundScore playerRoundScore) {
    int score = 0;
    int bids = playerRoundScore.bids;
    int tricksWon = playerRoundScore.tricksWon;
    Map<BonusKey, Bonus> bonusPoints = playerRoundScore.bonusPoints;

    if (bids == tricksWon) {
      if (bids == 0) {
        score = round.getValue() * 10;
      } else {
        score = tricksWon * 20;
      }
      bonusPoints.forEach((bonusKey, bonus) {
        if (bonus.amount > 0) {
          score += bonus.amount * bonus.value;
        }
      });
    } else {
      if (bids == 0) {
        score = -(round.getValue() * 10);
      } else {
        int difference = (bids - tricksWon).abs();
        score = -(difference * 10);
      }
      int? rascalPoints = bonusPoints[BonusKey.rascalBet]?.amount;
      if (rascalPoints != null && rascalPoints > 0) {
        score -= rascalPoints * bonusPoints[BonusKey.rascalBet]!.value;
      }
    }
    return score;
  }
}
