import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_total_score.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/list_utils.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState(Round(0))) {
    on<GameStarted>(onStartRound);
    on<GameRoundEnded>(onEndRound);
    on<GamePreviousRound>(onPreviousRound);
  }

  void onStartRound(GameStarted event, Emitter<GameState> emit) {
    List<PlayerRoundScore> newRoundScoresPlayers = List.generate(
      event.playersInGame.length,
      (index) => PlayerRoundScore(event.playersInGame[index].id, 0),
    );

    emit(
      GameState(
        const Round(1),
        playersInGame: event.playersInGame,
        roundHistory: [newRoundScoresPlayers],
      ),
    );
  }

  void onEndRound(GameRoundEnded event, Emitter<GameState> emit) {
    List<PlayerRoundScore> nextRoundScoresPlayers = List.empty(growable: true);
    List<Player> playersInGame = List.from(state.playersInGame);
    List<List<PlayerRoundScore>> roundHistory = List.from(state.roundHistory);

    roundHistory[state.round.getValue() - 1] = event.playersScores;
    for (var i = 0; i < event.playersScores.length; i++) {
      PlayerRoundScore scorePlayer = event.playersScores[i];
      int totalComputedRoundScore =
          GetTotalScore.execute(state.round, scorePlayer);

      nextRoundScoresPlayers.add(PlayerRoundScore(
        scorePlayer.playerId,
        totalComputedRoundScore,
      ));
      _updatePlayerScore(
          totalComputedRoundScore, playersInGame, scorePlayer.playerId);
    }
    if (state.historyStatus == GameHistorySatus.behind) {
      _currentRoundIsBehindHistory(
        event.playersScores,
        roundHistory,
        nextRoundScoresPlayers,
      );
    } else {
      roundHistory.add(nextRoundScoresPlayers);
    }
    emit(
      state.copyWith(
        round: Round(state.round.getValue() + 1),
        roundHistory: roundHistory,
        playersInGame: playersInGame,
        historyStatus: GameHistorySatus.normal,
      ),
    );
  }

  void onPreviousRound(GamePreviousRound event, Emitter<GameState> emit) {
    List<List<PlayerRoundScore>> roundHistory = List.from(state.roundHistory);
    List<Player> playersInGame = List.from(state.playersInGame);
    List<PlayerRoundScore> scoresFromPreviousRound =
        roundHistory[state.round.getValue() - 2];

    for (var i = 0; i < scoresFromPreviousRound.length; i++) {
      PlayerRoundScore scorePlayer = scoresFromPreviousRound[i];
      _updatePlayerScore(
          scorePlayer.currentScore, playersInGame, scorePlayer.playerId);
    }
    emit(
      state.copyWith(
        round: Round(state.round.getValue() - 1),
        playersInGame: playersInGame,
        historyStatus: GameHistorySatus.behind,
      ),
    );
  }

  void _updatePlayerScore(
    int score,
    List<Player> playersInGame,
    UniqueKey playerId,
  ) {
    int playerIdx = playersInGame.indexWhere(
      (player) => player.id == playerId,
    );
    playersInGame[playerIdx] = playersInGame[playerIdx].copyWith(
      score: score,
    );
  }

  void _currentRoundIsBehindHistory(
    List<PlayerRoundScore> eventPlayersScores,
    List<List<PlayerRoundScore>> roundHistory,
    List<PlayerRoundScore> nextRoundScoresPlayers,
  ) {
    if (ListUtils.areListsNotEquals<PlayerRoundScore>(
      eventPlayersScores,
      state.roundHistory[state.round.getValue() - 1],
    )) {
      roundHistory.removeRange(state.round.getValue(), roundHistory.length);
      roundHistory.add(nextRoundScoresPlayers);
    }
  }
}
