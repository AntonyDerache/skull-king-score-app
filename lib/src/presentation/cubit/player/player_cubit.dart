import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';

class PlayerCubit extends Cubit<List<PlayerState>> {
  PlayerCubit() : super(List<PlayerState>.generate(2, (_) => PlayerState(UniqueKey())));

  void addPlayer() {
    state.add(PlayerState(UniqueKey()));
    emit([...state]);
  }

  void removePlayer() {
    state.removeLast();
    emit([...state]);
  }

  void updatePlayerName(UniqueKey playerId, String newName) {
    final int index = state.indexWhere((player) => player.id == playerId);
    if (index == -1) return;
    state[index] = state[index].copyWith(name: newName);
    emit([...state]);
  }

  void updatePlayerScore(UniqueKey playerId, int newScore) {
    final int index = state.indexWhere((player) => player.id == playerId);
    if (index == -1) return;
    state[index] = state[index].copyWith(score: newScore);
    emit([...state]);
  }

  List<PlayerState> getLeadPlayers() {
    int higherScore = state
        .reduce((currentPlayer, nextPlayer) =>
            currentPlayer.score > nextPlayer.score ? currentPlayer : nextPlayer)
        .score;

    List<PlayerState> leadPlayers = List.empty(growable: true);

    for (var element in state) {
      if (element.score == higherScore) {
        leadPlayers.add(element);
      }
    }
    return leadPlayers;
  }

  List<PlayerState> getResultList() {
    List<PlayerState> resultList = List.from(state);

    resultList.sort((a, b) => b.score.compareTo(a.score));
    return resultList;
  }
}
