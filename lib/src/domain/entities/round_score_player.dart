import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';

class RoundScorePlayer {
  UniqueKey playerId;
  int bids = 0;
  int tricksWon = 0;
  Map<BonusKey, Bonus> bonusPoints = Map.from({
    BonusKey.pirate: Bonus(30),
    BonusKey.mermaid: Bonus(20),
    BonusKey.skullKing: Bonus(40),
    BonusKey.tenPoints: Bonus(10),
    BonusKey.alliance: Bonus(20),
    BonusKey.rascalBet: Bonus(10),
  });
  int currentScore = 0;

  RoundScorePlayer(this.playerId, this.currentScore);

  void updatePlayerBonusAmount(
      UniqueKey playerId, BonusKey bonusKey, int amount) {
    bonusPoints.update(bonusKey, (bonus) {
      bonus.amount = amount;
      return bonus;
    });
  }

  void updatePlayerBidsValue(UniqueKey playerId, int value) {
    bids = value;
  }

  void updatePlayerWonTricksValue(UniqueKey playerId, int value) {
    tricksWon = value;
  }
}
