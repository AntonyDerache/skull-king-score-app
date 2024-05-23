import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_total_score.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_state.dart';

class RoundCubit extends Cubit<List<RoundState>> {
  RoundCubit() : super(List<RoundState>.empty(growable: true));

  List<RoundScorePlayer> initNewRound(List<PlayerState> players, int round) {
    var roundScorePlayers = List<RoundScorePlayer>.empty(growable: true);

    for (PlayerState player in players) {
      if (round > 1) {
        int currentPlayerScore = GetTotalScore.call(
            round - 1, state[round - 2].playersMapScore[player.id]!);
        roundScorePlayers.add(RoundScorePlayer(player.id, currentPlayerScore));
      } else {
        roundScorePlayers.add(RoundScorePlayer(player.id, 0));
      }
    }

    state.add(RoundState(roundScorePlayers));
    emit([...state]);
    return roundScorePlayers;
  }

  void endRound(List<RoundScorePlayer> roundScorePlayers, int round) {
    for (RoundScorePlayer playerRoundScore in roundScorePlayers) {
      state[round - 1]
          .playersMapScore
          .update(playerRoundScore.playerId, (value) => playerRoundScore);
    }
    emit([...state]);
  }

  int getCurrentPlayerRoundScore(UniqueKey playerId, int round) {
    return state[round - 1].calculPlayerRoundScore(playerId, round);
  }
}
