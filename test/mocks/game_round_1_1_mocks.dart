import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';

import 'game_bloc_mocks.dart';

List<Player> mockPlayersRound1 = [
  Player(mockPlayers[0].id, score: 20),
  Player(mockPlayers[1].id, score: -10),
];

List<PlayerRoundScore> mockEndRoundScore1 = [
  PlayerRoundScore.init(
      mockPlayers[0].id, mockPlayers[0].score, 1, 1, mockEmptyBonusMap),
  PlayerRoundScore.init(
      mockPlayers[1].id, mockPlayers[1].score, 1, 0, mockEmptyBonusMap),
];

GameState mockGameStateRound2 = GameState(
  const Round(2),
  playersInGame: mockPlayersRound1,
  roundHistory: [
    [
      mockNewRoundScoresPlayers[0].copyWith(bids: 1, tricksWon: 1),
      mockNewRoundScoresPlayers[1].copyWith(bids: 1),
    ],
    [
      mockEndRoundScore1[0].copyWith(currentScore: 20, bids: 0, tricksWon: 0),
      mockEndRoundScore1[1].copyWith(currentScore: -10, bids: 0),
    ]
  ],
  historyStatus: GameHistorySatus.normal,
);
