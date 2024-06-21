import 'package:bloc/bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_total_score.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState(Round(0))) {
    on<GameStartRound>(onStartRound);
    on<GameEndRound>(onEndRound);
    on<GamePreviousRound>(onPreviousRound);
  }

  void onStartRound(GameStartRound event, Emitter<GameState> emit) {
    List<PlayerRoundScore> newRoundScoresPlayers = List.generate(
      event.playersInGame.length,
      (index) => PlayerRoundScore(event.playersInGame[index].id, 0),
    );

    emit(
      GameState(
        Round(1),
        playersInGame: event.playersInGame,
        roundHistory: [newRoundScoresPlayers],
      ),
    );
  }

  void onEndRound(GameEndRound event, Emitter<GameState> emit) {
    List<PlayerRoundScore> nextRoundScoresPlayers = List.empty(growable: true);
    List<Player> playersInGame = List.from(state.playersInGame);
    List<List<PlayerRoundScore>> roundHistory = List.from(state.roundHistory);

    roundHistory[state.round.getValue() - 1] = event.playersScores;
    for (var i = 0; i < event.playersScores.length; i++) {
      PlayerRoundScore scorePlayer = event.playersScores[i];

      int totalComputedRoundScore =
          GetTotalScore.execute(state.round, scorePlayer);
      nextRoundScoresPlayers
          .add(PlayerRoundScore(scorePlayer.playerId, totalComputedRoundScore));

      int playerIdx = playersInGame.indexWhere(
        (player) => player.id == scorePlayer.playerId,
      );
      playersInGame[playerIdx] = playersInGame[playerIdx].copyWith(
        score: totalComputedRoundScore,
      );
    }
    if (state.round.getValue() == roundHistory.length) {
      roundHistory.add(nextRoundScoresPlayers);
    }
    emit(
      state.copyWith(
        round: Round(state.round.getValue() + 1),
        roundHistory: roundHistory,
        playersInGame: playersInGame,
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

      int playerIdx = playersInGame.indexWhere(
        (player) => player.id == scorePlayer.playerId,
      );
      playersInGame[playerIdx] = playersInGame[playerIdx].copyWith(
        score: scorePlayer.currentScore,
      );
    }

    emit(
      state.copyWith(
        round: Round(state.round.getValue() - 1),
        playersInGame: playersInGame,
      ),
    );
  }
}
