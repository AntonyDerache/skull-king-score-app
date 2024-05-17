import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_state.dart';

class RoundCubit extends Cubit<List<RoundState>> {
  RoundCubit() : super(List<RoundState>.empty(growable: true));

  void initNewRound(List<UniqueKey> players) {
    // calcul new score from previous if applicable
    state.add(RoundState(players, state.length));
    emit([...state]);
  }

   void endRound(int round, List<RoundScorePlayer> playersRoundScores) {
    for(var playerRoundScore in playersRoundScores) {
      state[round].playersMapScore[playerRoundScore.playerId] = playerRoundScore;
    }
    emit([...state]);
  }
}
