import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';

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
