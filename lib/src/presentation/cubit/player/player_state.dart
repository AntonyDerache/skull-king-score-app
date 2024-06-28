import 'package:equatable/equatable.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';

enum PlayerCubitActions {
  none,
  playerAdded,
  playersRemoved,
  playerScoreUpdated,
  playerNameUpdated,
}

class PlayerRemoved extends Equatable {
  final Player player;
  final int index;

  const PlayerRemoved(this.player, this.index);

  @override
  bool operator ==(Object other) {
    return other is PlayerRemoved && player == other.player && index == other.index;
  }

  @override
  List<Object?> get props => [player, index];

  @override
  int get hashCode => Object.hash(player, index);
}

class PlayerState extends Equatable {
  final List<Player> players;
  final PlayerCubitActions lastPlayerAction;
  final List<PlayerRemoved> lastRemovedPlayers;

  const PlayerState(
    this.players, {
    this.lastPlayerAction = PlayerCubitActions.none,
    this.lastRemovedPlayers = const [],
  });

  PlayerState copyWith({
    List<Player>? players,
    PlayerCubitActions? lastPlayerAction,
    List<PlayerRemoved>? lastRemovedPlayers,
  }) {
    return PlayerState(
      players ?? this.players,
      lastRemovedPlayers: lastRemovedPlayers ?? this.lastRemovedPlayers,
      lastPlayerAction: lastPlayerAction ?? this.lastPlayerAction,
    );
  }

  @override
  List<Object?> get props => [players];
}
