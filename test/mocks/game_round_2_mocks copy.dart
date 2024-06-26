import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';

import 'game_bloc_mocks.dart';
import 'game_round_1_1_mocks.dart';

List<Player> mockPlayersRound2 = [
  Player(mockPlayers[0].id, score: 0),
  Player(mockPlayers[1].id, score: 40),
];

List<PlayerRoundScore> mockEndRoundScore2 = [
  PlayerRoundScore.init(mockPlayersRound1[0].id, mockPlayersRound1[0].score, 0,
      1, mockEmptyBonusMap),
  PlayerRoundScore.init(mockPlayersRound1[1].id, mockPlayersRound1[1].score, 1,
      1, {...mockBonusMapWithOnePirate}),
];

GameState mockGameStateRound3 = GameState(
  const Round(3),
  playersInGame: mockPlayersRound2,
  roundHistory: [
    [
      mockNewRoundScoresPlayers[0].copyWith(bids: 1, tricksWon: 1),
      mockNewRoundScoresPlayers[1].copyWith(bids: 1),
    ],
    [
      mockEndRoundScore1[0].copyWith(currentScore: 20, bids: 0, tricksWon: 1),
      mockEndRoundScore1[1].copyWith(
          currentScore: -10,
          bids: 1,
          tricksWon: 1,
          bonusPoints: {...mockBonusMapWithOnePirate}),
    ],
    [
      mockEndRoundScore2[0].copyWith(currentScore: 0, tricksWon: 0),
      mockEndRoundScore2[1].copyWith(
          currentScore: 40,
          bids: 0,
          tricksWon: 0,
          bonusPoints: {...mockEmptyBonusMap}),
    ]
  ],
  historyStatus: GameHistorySatus.normal,
);
