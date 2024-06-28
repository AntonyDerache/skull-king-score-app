import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit()
      : super(
          PlayerState(
            List.generate(
              2,
              (_) => Player(UniqueKey()),
            ),
          ),
        );

  void addPlayer() {
    List<Player> updatedPlayers = List.from(state.players);

    updatedPlayers.add(Player(UniqueKey()));
    emit(
      state.copyWith(
        players: updatedPlayers,
        lastPlayerAction: PlayerCubitActions.playerAdded,
        lastRemovedPlayers: [],
      ),
    );
  }

  void removePlayer() {
    List<Player> updatedPlayers = List.from(state.players);
    PlayerRemoved playerToRemove =
        PlayerRemoved(updatedPlayers.last, updatedPlayers.length - 1);

    updatedPlayers.removeLast();
    emit(
      state.copyWith(
        players: updatedPlayers,
        lastPlayerAction: PlayerCubitActions.playersRemoved,
        lastRemovedPlayers: [playerToRemove],
      ),
    );
  }

  void removePlayersById(List<UniqueKey> ids) {
    List<Player> updatedPlayers = List.from(state.players);
    List<PlayerRemoved> playersToRemove = [];

    for (UniqueKey id in ids) {
      int idx = updatedPlayers.indexWhere((player) => player.id == id);
      if (idx == -1) continue;
      playersToRemove.add(PlayerRemoved(updatedPlayers[idx], idx));
      updatedPlayers.removeAt(idx);
    }
    emit(
      state.copyWith(
        players: updatedPlayers,
        lastPlayerAction: PlayerCubitActions.playersRemoved,
        lastRemovedPlayers: playersToRemove,
      ),
    );
  }

  void updatePlayerName(UniqueKey playerId, String newName) {
    final List<Player> updatedPlayers = List.from(state.players);
    final int index =
        updatedPlayers.indexWhere((player) => player.id == playerId);

    if (index == -1) return;
    updatedPlayers[index] = updatedPlayers[index].copyWith(name: newName);
    emit(
      state.copyWith(
        players: updatedPlayers,
        lastPlayerAction: PlayerCubitActions.playerNameUpdated,
        lastRemovedPlayers: [],
      ),
    );
  }

  void updatePlayerScore(UniqueKey playerId, int newScore) {
    final List<Player> updatedPlayers = List.from(state.players);
    final int index =
        updatedPlayers.indexWhere((player) => player.id == playerId);

    if (index == -1) return;
    updatedPlayers[index] = updatedPlayers[index].copyWith(score: newScore);
    emit(
      state.copyWith(
        players: updatedPlayers,
        lastPlayerAction: PlayerCubitActions.playerScoreUpdated,
        lastRemovedPlayers: [],
      ),
    );
  }
}
