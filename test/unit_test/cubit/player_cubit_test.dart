import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';

void main() {
  group(PlayerCubit, () {
    test('Player Cubit initial state is correct', () {
      // GIVEN
      // WHEN
      PlayerCubit playerCubit = PlayerCubit();
      // THEN
      expect(playerCubit.state.length, 2);
      expect(playerCubit.state[0].score, 0);
      expect(playerCubit.state[0].name, '');
    });

    test("add a new player", () {
      // GIVEN
      PlayerCubit playerCubit = PlayerCubit();
      // WHEN
      playerCubit.addPlayer();
      // THEN
      expect(playerCubit.state.length, 3);
    });

    test("remove a player", () {
      // GIVEN
      PlayerCubit playerCubit = PlayerCubit();
      // WHEN
      playerCubit.removePlayer();
      // THEN
      expect(playerCubit.state.length, 1);
    });

    test("update player's name", () {
      // GIVEN
      PlayerCubit playerCubit = PlayerCubit();
      UniqueKey playerId = playerCubit.state[0].id;
      String newPlayerName = "Toto";
      // WHEN
      playerCubit.updatePlayerName(playerId, newPlayerName);
      // THEN
      expect(playerCubit.state[0].name, newPlayerName);
    });

    test("update player's score", () {
      // GIVEN
      PlayerCubit playerCubit = PlayerCubit();
      UniqueKey playerId = playerCubit.state[0].id;
      int newPlayerScore = 80;
      // WHEN
      playerCubit.updatePlayerScore(playerId, newPlayerScore);
      // THEN
      expect(playerCubit.state[0].score, newPlayerScore);
    });
  });
}
