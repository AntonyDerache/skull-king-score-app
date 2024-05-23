import 'package:flutter/material.dart';

enum BonusKey { pirate, mermaid, skullKing, tenPoints, alliance, bet }

class Bonus {
  int value;
  int amount = 0;

  Bonus(this.value);
}

final Map<BonusKey, Bonus> bonusTable = Map.from({
  BonusKey.pirate: Bonus(30),
  BonusKey.mermaid: Bonus(30),
  BonusKey.skullKing: Bonus(30),
  BonusKey.tenPoints: Bonus(10),
  BonusKey.alliance: Bonus(10),
  BonusKey.bet: Bonus(10),
});

class RoundScorePlayer {
  UniqueKey playerId;
  int bids = 0;
  int tricksWon = 0;
  Map<BonusKey, Bonus> bonusPoints = Map.from({
    BonusKey.pirate: Bonus(30),
    BonusKey.mermaid: Bonus(30),
    BonusKey.skullKing: Bonus(30),
    BonusKey.tenPoints: Bonus(10),
    BonusKey.alliance: Bonus(10),
    BonusKey.bet: Bonus(10),
  });
  int currentScore = 0;

  RoundScorePlayer(this.playerId, this.currentScore);

  int calculRoundScore(int round) {
    int score = 0;

    if (bids == tricksWon) {
      if (bids == 0) {
        score = round * 10;
      } else {
        tricksWon * 20;
      }
      bonusPoints.forEach((bonusKey, bonus) {
        if (bonus.amount > 0) {
          score += bonus.amount * bonus.value;
        }
      });
    } else {
      if (bids == 0) {
        score = -(round * 10);
      } else {
        int difference = (bids - tricksWon).abs();
        score = -(difference * 10);
      }
    }
    return score;
  }

  int getTotalScore(int round) {
    return currentScore + calculRoundScore(round);
  }

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

final class RoundState {
  Map<UniqueKey, RoundScorePlayer> playersMapScore = {};

  RoundState(List<RoundScorePlayer> roundScorePlayers) {
    for (RoundScorePlayer roundScorePlayer in roundScorePlayers) {
      playersMapScore[roundScorePlayer.playerId] = roundScorePlayer;
    }
  }

  int calculPlayerRoundScore(UniqueKey playerId, int round) {
    RoundScorePlayer roundScorePlayer = playersMapScore[playerId]!;

    return roundScorePlayer.currentScore;
  }
}
