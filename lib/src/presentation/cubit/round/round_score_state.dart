import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';

final class RoundScoreState {
  List<RoundScorePlayer> playersMapScore = List.empty(growable: true);

  RoundScoreState(List<RoundScorePlayer> roundScorePlayers) {
    playersMapScore = List.from(roundScorePlayers);
  }

  bool replaceWhere(UniqueKey id, RoundScorePlayer newItem) {
    int itemIndex = playersMapScore.indexWhere((item) => item.playerId == id);

    if (itemIndex != -1) {
      playersMapScore[itemIndex] = newItem;
      return true;
    }
    return false;
  }

  RoundScorePlayer getRoundScorePlayer(UniqueKey id) {
    return playersMapScore.firstWhere((element) => element.playerId == id);
  }

  int calculPlayerRoundScore(UniqueKey playerId) {
    RoundScorePlayer player =
        playersMapScore.firstWhere((element) => element.playerId == playerId);

    return player.currentScore;
  }
}
