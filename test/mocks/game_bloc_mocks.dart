import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';

List<Player> mockPlayers = List.generate(2, (_) => Player(UniqueKey()));

List<PlayerRoundScore> mockNewRoundScoresPlayers = List.generate(
  mockPlayers.length,
  (index) => PlayerRoundScore(mockPlayers[index].id, 0),
);

GameState mockGameStartRound = GameState(
  const Round(1),
  playersInGame: mockPlayers,
  roundHistory: [mockNewRoundScoresPlayers],
  historyStatus: GameHistorySatus.normal,
);

Map<BonusKey, Bonus> mockEmptyBonusMap = {
  BonusKey.pirate: const Bonus(30),
  BonusKey.mermaid: const Bonus(20),
  BonusKey.skullKing: const Bonus(40),
  BonusKey.tenPoints: const Bonus(10),
  BonusKey.alliance: const Bonus(20),
  BonusKey.rascalBet: const Bonus(10),
};

Map<BonusKey, Bonus> mockBonusMapWithOnePirate = {
  BonusKey.pirate: const Bonus(30, 1),
  BonusKey.mermaid: const Bonus(20),
  BonusKey.skullKing: const Bonus(40),
  BonusKey.tenPoints: const Bonus(10),
  BonusKey.alliance: const Bonus(20),
  BonusKey.rascalBet: const Bonus(10),
};
