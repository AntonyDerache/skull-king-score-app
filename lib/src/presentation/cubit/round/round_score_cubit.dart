import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_total_score.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_score_state.dart';

class RoundScoreCubit extends Cubit<List<RoundScoreState>> {
  RoundScoreCubit() : super(List<RoundScoreState>.empty(growable: true));

  void initNewRound(List<PlayerState> players, Round round) {
    if (round.getValue() == state.length - 1) {
      state.removeLast();
    } else {
      List<RoundScorePlayer> roundScorePlayers =
          List.from(setNewScoreToPlayers(players, round));
      state.add(RoundScoreState(roundScorePlayers));
    }
    emit([...state]);
  }

  List<RoundScorePlayer> setNewScoreToPlayers(
      List<PlayerState> players, Round round) {
    var roundScorePlayers = List<RoundScorePlayer>.empty(growable: true);

    for (PlayerState player in players) {
      if (round.getValue() > 1) {
        int currentPlayerScore = GetTotalScore.execute(Round(round.getValue() - 1),
            state[round.getValue() - 2].getRoundScorePlayer(player.id));
        roundScorePlayers.add(RoundScorePlayer(player.id, currentPlayerScore));
      } else {
        roundScorePlayers.add(RoundScorePlayer(player.id, 0));
      }
    }
    return roundScorePlayers;
  }

  void endRound(List<RoundScorePlayer> roundScorePlayers, Round round) {
    for (RoundScorePlayer playerRoundScore in roundScorePlayers) {
      state[round.getValue() - 1]
          .replaceWhere(playerRoundScore.playerId, playerRoundScore);
    }
    emit([...state]);
  }

  int getCurrentPlayerRoundScore(UniqueKey playerId, Round round) {
    return state[round.getValue() - 1].calculPlayerRoundScore(playerId);
  }

  int getRoundTicksWon(List<RoundScorePlayer> roundScorePlayers) {
    int totalWin = 0;
    for (var score in roundScorePlayers) {
      totalWin += score.tricksWon;
    }
    return totalWin;
  }

  void reset() {
    emit(List<RoundScoreState>.empty(growable: true));
  }
}
