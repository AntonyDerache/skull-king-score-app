import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';

import '../../mocks/game_bloc_mocks.dart';
import '../../mocks/game_round_1_1_mocks.dart';
import '../../mocks/game_round_1_2_mocks.dart';
import '../../mocks/game_round_2_mocks.dart';

void main() {
  group(GameBloc, () {
    test('Game bloc initial state is correct', () {
      // GIVEN
      GameState expectedState = const GameState(Round(0));
      // WHEN
      GameBloc initialBloc = GameBloc();
      // THEN
      expect(initialBloc.state, equals(expectedState));
    });

    group('onStartRound', () {
      // GIVEN
      GameState expectState = mockGameStarted.copyWith();
      blocTest<GameBloc, GameState>(
        "emit state [round 1, players, roundHistory] for a new game",
        build: () => GameBloc(),
        // WHEN
        act: (bloc) => bloc.add(GameStarted(List.from(mockPlayers))),
        // THEN
        expect: () => [
          isA<GameState>()
              .having((actual) => actual.round, "round", expectState.round)
              .having((actual) => actual.playersInGame, "playersInGame",
                  expectState.playersInGame)
              .having((actual) => actual.roundHistory, "roundHistory",
                  expectState.roundHistory)
              .having((actual) => actual.historyStatus, "historyStatus",
                  expectState.historyStatus)
        ],
      );
    });

    group('onEndRound', () {
      blocTest<GameBloc, GameState>(
        "emit state from round 1 to round 2",
        // GIVEN
        build: () => GameBloc(),
        seed: () => mockGameStarted,
        // WHEN
        act: (bloc) => bloc.add(GameRoundEnded(List.from(mockEndRoundScore1))),
        // THEN
        expect: () => [
          isA<GameState>()
              .having(
                  (actual) => actual.round, "round", mockGameStateRound2.round)
              .having((actual) => actual.playersInGame, "playersInGame",
                  mockGameStateRound2.playersInGame)
              .having((actual) => actual.roundHistory, "roundHistory",
                  mockGameStateRound2.roundHistory)
              .having((actual) => actual.historyStatus, "historyStatus",
                  mockGameStateRound2.historyStatus)
        ],
      );
      blocTest<GameBloc, GameState>(
        "emit state from round 2 to round 3 with bonus",
        // GIVEN
        build: () => GameBloc(),
        seed: () => mockGameStateRound2,
        // WHEN
        act: (bloc) => bloc.add(GameRoundEnded(List.from(mockEndRoundScore2))),
        // THEN
        expect: () => [
          isA<GameState>()
              .having(
                  (actual) => actual.round, "round", mockGameStateRound3.round)
              .having((actual) => actual.playersInGame, "playersInGame",
                  mockGameStateRound3.playersInGame)
              .having((actual) => actual.roundHistory, "roundHistory",
                  mockGameStateRound3.roundHistory)
              .having((actual) => actual.historyStatus, "historyStatus",
                  mockGameStateRound3.historyStatus)
        ],
      );
      blocTest<GameBloc, GameState>(
        "emit new round after a previousRound event",
        // GIVEN
        build: () => GameBloc(),
        seed: () => mockGameStateRound3,
        // WHEN
        act: (bloc) {
          bloc.add(GamePreviousRound());
          bloc.add(GamePreviousRound());
          bloc.add(GameRoundEnded(List.from(mockEndRoundScore1_2)));
        },
        skip: 2,
        // THEN
        expect: () => [
          isA<GameState>()
              .having((actual) => actual.round, "round",
                  mockGameStateRound2_2.round)
              .having((actual) => actual.playersInGame, "playersInGame",
                  mockGameStateRound2_2.playersInGame)
              .having((actual) => actual.roundHistory, "roundHistory",
                  mockGameStateRound2_2.roundHistory)
              .having((actual) => actual.historyStatus, "historyStatus",
                  mockGameStateRound2_2.historyStatus)
        ],
      );
    });

    group('onPreviousRound', () {
      blocTest<GameBloc, GameState>(
        "emit state with round - 1 with history.behind status",
        // GIVEN
        build: () => GameBloc(),
        seed: () => mockGameStateRound3,
        // WHEN
        act: (bloc) => bloc.add(GamePreviousRound()),
        // THEN
        expect: () => [
          isA<GameState>()
              .having(
                  (actual) => actual.round, "round", mockGameStateRound2.round)
              .having((actual) => actual.playersInGame, "playersInGame",
                  mockGameStateRound2.playersInGame)
              .having((actual) => actual.roundHistory, "roundHistory",
                  mockGameStateRound3.roundHistory)
              .having((actual) => actual.historyStatus, "historyStatus",
                  GameHistorySatus.behind)
        ],
      );
    });
  });
}
