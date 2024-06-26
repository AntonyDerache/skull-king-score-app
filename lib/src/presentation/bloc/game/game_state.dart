import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';

enum GameHistorySatus { normal, behind }

class GameState extends Equatable {
  final Round round;
  final List<Player> playersInGame;
  final List<List<PlayerRoundScore>> roundHistory;
  final GameHistorySatus historyStatus;

  const GameState(
    this.round, {
    this.playersInGame = const [],
    this.roundHistory = const [[]],
    this.historyStatus = GameHistorySatus.normal,
  });

  @override
  String toString() {
    return 'Current round: ${round.getValue()}';
  }

  GameState copyWith({
    Round? round,
    List<List<PlayerRoundScore>>? roundHistory,
    List<Player>? playersInGame,
    GameHistorySatus? historyStatus,
  }) {
    return GameState(
      round ?? this.round,
      roundHistory: roundHistory ?? this.roundHistory,
      playersInGame: playersInGame ?? this.playersInGame,
      historyStatus: historyStatus ?? GameHistorySatus.normal,
    );
  }

  @override
  List<Object?> get props => [
        round,
        roundHistory,
        playersInGame,
        historyStatus,
      ];

  @override
  bool operator ==(Object other) {
    return other is GameState &&
        round == other.round &&
        listEquals(playersInGame, other.playersInGame) &&
        listEquals(roundHistory, other.roundHistory) &&
        historyStatus == other.historyStatus;
  }

  @override
  int get hashCode => Object.hash(
        round,
        playersInGame,
        roundHistory,
        historyStatus,
      );
}
