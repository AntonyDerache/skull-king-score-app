import 'package:flutter/material.dart';

enum BonusKey {
  pirate,
  mermaid,
  skullKing,
  tenPoints,
  alliance,
  bet
}

class Bonus {
  int value;
  int amount = 0;

  Bonus(this.value);
}

class RoundScorePlayer {
  UniqueKey playerId;
  int bids = 0;
  int tricksWon = 0;
  Map<BonusKey, Bonus> bonusPoints = Map.from({
    BonusKey.pirate, Bonus(30),
    BonusKey.mermaid, Bonus(30),
    BonusKey.skullKing, Bonus(30),
    BonusKey.tenPoints, Bonus(10),
    BonusKey.alliance, Bonus(10),
    BonusKey.bet, Bonus(10),
  } as Map) ;
  int currentScore = 0;

  RoundScorePlayer(this.playerId, this.currentScore);

  void calculRoundScore() {
    throw UnimplementedError();
  }
}

final class RoundState {
  Map<UniqueKey, RoundScorePlayer> playersMapScore = {};

  RoundState(List<UniqueKey> playersId, int currentRound) {
    for (var playerId in playersId) {
      playersMapScore[playerId] = RoundScorePlayer(playerId, 0);
    }
  }
}
