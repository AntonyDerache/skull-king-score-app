import 'package:bloc/bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_total_score.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_state.dart';

class RoundBloc extends Bloc<RoundEvent, RoundState> {
  RoundBloc() : super(RoundState(Round(0))) {
    on<StartRound>(onStartRound);
    on<EndRound>(onEndRound);
    on<PreviousRound>(onPreviousRound);
  }

  void onStartRound(StartRound event, Emitter<RoundState> emit) {
    List<RoundScorePlayer> newRoundScoresPlayers = List.generate(
      event.playersInGame.length,
      (index) => RoundScorePlayer(event.playersInGame[index].id, 0),
    );

    emit(RoundState(Round(1),
        playersInGame: event.playersInGame,
        roundHistory: [newRoundScoresPlayers]));
  }

  void onEndRound(EndRound event, Emitter<RoundState> emit) {
    List<RoundScorePlayer> nextRoundScoresPlayers = List.empty(growable: true);
    List<Player> playersInGame = List.from(state.playersInGame);
    List<List<RoundScorePlayer>> roundHistory = List.from(state.roundHistory);
    List<RoundScorePlayer> currentRoundScores =
        roundHistory[state.round.getValue() - 1];
    currentRoundScores = event.playersScores;

    for (var i = 0; i < currentRoundScores.length; i++) {
      RoundScorePlayer scorePlayer = currentRoundScores[i];

      int totalComputedRoundScore =
          GetTotalScore.execute(state.round, scorePlayer);
      nextRoundScoresPlayers
          .add(RoundScorePlayer(scorePlayer.playerId, totalComputedRoundScore));

      int playerIdx = playersInGame.indexWhere(
        (player) => player.id == scorePlayer.playerId,
      );
      playersInGame[playerIdx] = playersInGame[playerIdx].copyWith(
        score: totalComputedRoundScore,
      );
    }
    roundHistory.add(nextRoundScoresPlayers);
    emit(
      state.copyWith(
        round: Round(state.round.getValue() + 1),
        roundHistory: roundHistory,
        playersInGame: playersInGame,
      ),
    );
  }

  void onPreviousRound(PreviousRound event, Emitter<RoundState> emit) {
    emit(RoundState(Round(state.round.getValue() - 1)));
  }
}
