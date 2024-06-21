import 'package:equatable/equatable.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';

class RoundState extends Equatable {
  final Round round;
  final List<Player> playersInGame;
  final List<List<RoundScorePlayer>> roundHistory;

  const RoundState(this.round,
      {this.playersInGame = const [], this.roundHistory = const [[]]});

  @override
  String toString() {
    return 'Current round: ${round.getValue()}';
  }

  RoundState copyWith({
    Round? round,
    List<List<RoundScorePlayer>>? roundHistory,
    List<Player>? playersInGame,
  }) {
    return RoundState(
      round ?? this.round,
      roundHistory: roundHistory ?? this.roundHistory,
      playersInGame: playersInGame ?? this.playersInGame,
    );
  }

  @override
  List<Object?> get props => [round, roundHistory, playersInGame];
}
