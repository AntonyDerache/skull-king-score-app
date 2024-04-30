import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/cubits/player/player_state.dart';

class PlayerCubit extends Cubit<List<PlayerState>> {
  PlayerCubit() : super(List<PlayerState>.generate(2, (_) => PlayerState()));

  void addPlayer() {
    state.add(PlayerState());
    emit([...state]);
  }

  void removePlayer() {
    state.removeLast();
    emit([...state]);
  }

  void updatePlayerName(UniqueKey playerId, String newName) {
    final int playerIndex = state.indexWhere((player) => player.id == playerId);

    if (playerIndex != -1) state[playerIndex].name = newName;
    emit([...state]);
  }

  void updatePlayerScore(UniqueKey playerId, int newScore) {
    final int playerIndex = state.indexWhere((player) => player.id == playerId);

    if (playerIndex != -1) state[playerIndex].score = newScore;
    emit([...state]);
  }

  int getNumberOfPlayer() {
    return state.length;
  }
}
