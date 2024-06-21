import 'package:flutter/foundation.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';

class PlayerRoundScore {
  UniqueKey playerId;
  int bids = 0;
  int tricksWon = 0;
  Map<BonusKey, Bonus> bonusPoints = Map.from({
    BonusKey.pirate: const Bonus(30),
    BonusKey.mermaid: const Bonus(20),
    BonusKey.skullKing: const Bonus(40),
    BonusKey.tenPoints: const Bonus(10),
    BonusKey.alliance: const Bonus(20),
    BonusKey.rascalBet: const Bonus(10),
  });
  int currentScore = 0;

  PlayerRoundScore(this.playerId, this.currentScore);

  void updatePlayerBonusAmount(
    UniqueKey playerId,
    BonusKey bonusKey,
    int amount,
  ) {
    bonusPoints.update(bonusKey, (bonus) {
      return Bonus(bonus.value, amount);
    });
  }

  void updatePlayerBidsValue(UniqueKey playerId, int value) {
    bids = value;
  }

  void updatePlayerWonTricksValue(UniqueKey playerId, int value) {
    tricksWon = value;
  }

  PlayerRoundScore.init(this.playerId, this.currentScore, this.bids,
      this.tricksWon, this.bonusPoints);

  factory PlayerRoundScore.clone(PlayerRoundScore source) {
    return PlayerRoundScore.init(
      source.playerId,
      source.currentScore,
      source.bids,
      source.tricksWon,
      {...source.bonusPoints},
    );
  }

  @override
  bool operator ==(Object other) =>
      other is PlayerRoundScore &&
      other.playerId == playerId &&
      other.bids == bids &&
      other.tricksWon == tricksWon &&
      other.currentScore == currentScore &&
      mapEquals(other.bonusPoints, bonusPoints);

  @override
  String toString() {
    return """
  player $playerId as $currentScore score
  bids $bids
  tricks $tricksWon
  bonus ${bonusPoints[BonusKey.pirate]} of ${BonusKey.pirate}
  bonus ${bonusPoints[BonusKey.mermaid]} of ${BonusKey.mermaid}
  bonus ${bonusPoints[BonusKey.skullKing]} of ${BonusKey.skullKing}
  bonus ${bonusPoints[BonusKey.tenPoints]} of ${BonusKey.tenPoints}
  bonus ${bonusPoints[BonusKey.alliance]} of ${BonusKey.alliance}
  bonus ${bonusPoints[BonusKey.rascalBet]} of ${BonusKey.rascalBet}
    """;
  }

  @override
  int get hashCode => Object.hash(
        playerId,
        bids,
        tricksWon,
        bonusPoints,
        currentScore,
      );
}
