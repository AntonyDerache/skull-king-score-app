import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';

void main() {
  group(PlayerCubit, () {
    test('Player Cubit initial state is correct', () {
      // GIVEN
      // WHEN
      final PlayerCubit playerCubit = PlayerCubit();
      // THEN
      expect(playerCubit.state.players.length, 2);
      expect(playerCubit.state.players[0].score, 0);
      expect(playerCubit.state.players[0].name, '');
      expect(playerCubit.state.lastPlayerAction, PlayerCubitActions.none);
      expect(playerCubit.state.lastRemovedPlayers.isEmpty, true);
    });

    test("add a new player", () {
      // GIVEN
      final PlayerCubit playerCubit = PlayerCubit();
      // WHEN
      playerCubit.addPlayer();
      // THEN
      expect(playerCubit.state.players.length, 3);
      expect(playerCubit.state.lastRemovedPlayers.isEmpty, true);
      expect(
          playerCubit.state.lastPlayerAction, PlayerCubitActions.playerAdded);
    });

    test("remove a player", () {
      // GIVEN
      final PlayerCubit playerCubit = PlayerCubit();
      final PlayerRemoved playerIdToRemove = PlayerRemoved(
          playerCubit.state.players.last,
          playerCubit.state.players.length - 1);
      // WHEN
      playerCubit.removePlayer();
      // THEN
      expect(playerCubit.state.players.length, 1);
      expect(playerCubit.state.lastRemovedPlayers[0], playerIdToRemove);
      expect(playerCubit.state.lastPlayerAction,
          PlayerCubitActions.playersRemoved);
    });

    test("remove player at", () {
      // GIVEN
      PlayerCubit playerCubit = PlayerCubit();
      playerCubit.addPlayer();
      playerCubit.addPlayer();
      final List expectedState = List.from(playerCubit.state.players);
      final List<UniqueKey> playersToDelete = [
        playerCubit.state.players[1].id,
        playerCubit.state.players[2].id
      ];
      final List<PlayerRemoved> expectedRemovedPlayers = [
        PlayerRemoved(playerCubit.state.players[1], 1),
        PlayerRemoved(playerCubit.state.players[2], 1)
      ];
      expectedState.removeAt(1);
      expectedState.removeAt(1);
      // WHEN
      playerCubit.removePlayersById(playersToDelete);
      // THEN
      expect(playerCubit.state.players, equals(expectedState));
      expect(
          playerCubit.state.lastRemovedPlayers, equals(expectedRemovedPlayers));
      expect(playerCubit.state.lastPlayerAction,
          PlayerCubitActions.playersRemoved);
    });

    test("update player's name", () {
      // GIVEN
      final PlayerCubit playerCubit = PlayerCubit();
      final UniqueKey playerId = playerCubit.state.players[0].id;
      const String newPlayerName = "Toto";
      // WHEN
      playerCubit.updatePlayerName(playerId, newPlayerName);
      // THEN
      expect(playerCubit.state.players[0].name, newPlayerName);
      expect(playerCubit.state.lastPlayerAction,
          PlayerCubitActions.playerNameUpdated);
    });

    test("update player's score", () {
      // GIVEN
      final PlayerCubit playerCubit = PlayerCubit();
      final UniqueKey playerId = playerCubit.state.players[0].id;
      const int newPlayerScore = 80;
      // WHEN
      playerCubit.updatePlayerScore(playerId, newPlayerScore);
      // THEN
      expect(playerCubit.state.players[0].score, newPlayerScore);
      expect(playerCubit.state.lastPlayerAction,
          PlayerCubitActions.playerScoreUpdated);
    });
  });
}
