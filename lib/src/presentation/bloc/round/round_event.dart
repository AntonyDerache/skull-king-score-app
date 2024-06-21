import 'package:equatable/equatable.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';

sealed class RoundEvent extends Equatable {
  const RoundEvent();
}

final class StartRound extends RoundEvent {
  final List<Player> playersInGame;

  const StartRound(this.playersInGame);

  @override
  List<Object?> get props => [playersInGame];
}

final class EndRound extends RoundEvent {
  final List<RoundScorePlayer> playersScores;

  const EndRound(this.playersScores);

  @override
  List<Object?> get props => [];
}

final class PreviousRound extends RoundEvent {
  @override
  List<Object?> get props => [];
}
