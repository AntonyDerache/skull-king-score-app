import 'package:equatable/equatable.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();
}

final class GameStarted extends GameEvent {
  final List<Player> playersInGame;

  const GameStarted(this.playersInGame);

  @override
  List<Object?> get props => [playersInGame];
}

final class GameRoundEnded extends GameEvent {
  final List<PlayerRoundScore> playersScores;

  const GameRoundEnded(this.playersScores);

  @override
  List<Object?> get props => [];
}

final class GamePreviousRound extends GameEvent {
  @override
  List<Object?> get props => [];
}
