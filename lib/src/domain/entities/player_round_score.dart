import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';

class PlayerRoundScore extends Equatable {
  final UniqueKey playerId;
  final int bids;
  final int tricksWon;
  final Map<BonusKey, Bonus> bonusPoints;
  final int currentScore;

  const PlayerRoundScore(
    this.playerId,
    this.currentScore, {
    this.bids = 0,
    this.tricksWon = 0,
    this.bonusPoints = const {
      BonusKey.pirate: Bonus(30),
      BonusKey.mermaid: Bonus(20),
      BonusKey.skullKing: Bonus(40),
      BonusKey.tenPoints: Bonus(10),
      BonusKey.alliance: Bonus(20),
      BonusKey.rascalBet: Bonus(10),
    },
  });

  const PlayerRoundScore.init(this.playerId, this.currentScore, this.bids,
      this.tricksWon, this.bonusPoints);

  PlayerRoundScore copyWith(
      {UniqueKey? playerId,
      int? currentScore,
      int? bids,
      int? tricksWon,
      Map<BonusKey, Bonus>? bonusPoints}) {
    return PlayerRoundScore(
      playerId ?? this.playerId,
      currentScore ?? this.currentScore,
      bids: bids ?? this.bids,
      tricksWon: tricksWon ?? this.tricksWon,
      bonusPoints:
          bonusPoints != null ? {...bonusPoints} : {...this.bonusPoints},
    );
  }

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

  @override
  List<Object?> get props => [
        playerId,
        currentScore,
        bids,
        tricksWon,
        bonusPoints,
      ];
}
