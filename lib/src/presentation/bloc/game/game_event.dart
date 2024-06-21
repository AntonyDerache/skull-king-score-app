import 'package:equatable/equatable.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();
}

final class GameStartRound extends GameEvent {
  final List<Player> playersInGame;

  const GameStartRound(this.playersInGame);

  @override
  List<Object?> get props => [playersInGame];
}

final class GameEndRound extends GameEvent {
  final List<PlayerRoundScore> playersScores;

  const GameEndRound(this.playersScores);

  @override
  List<Object?> get props => [];
}

final class GamePreviousRound extends GameEvent {
  @override
  List<Object?> get props => [];
}
