import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';

import 'game_bloc_mocks.dart';

List<Player> mockPlayersRound1_2 = [
  Player(mockPlayers[0].id, score: -10),
  Player(mockPlayers[1].id, score: -10),
];

List<PlayerRoundScore> mockEndRoundScore1_2 = [
  PlayerRoundScore.init(
      mockPlayers[0].id, mockPlayers[0].score, 0, 1, mockEmptyBonusMap),
  PlayerRoundScore.init(
      mockPlayers[1].id, mockPlayers[1].score, 1, 0, mockEmptyBonusMap),
];

GameState mockGameStateRound2_2 = GameState(
  const Round(2),
  playersInGame: mockPlayersRound1_2,
  roundHistory: [
    [
      mockNewRoundScoresPlayers[0].copyWith(tricksWon: 1),
      mockNewRoundScoresPlayers[1].copyWith(bids: 1),
    ],
    [
      mockEndRoundScore1_2[0].copyWith(currentScore: -10, tricksWon: 0),
      mockEndRoundScore1_2[1].copyWith(
        currentScore: -10,
        bids: 0,
      ),
    ],
  ],
  historyStatus: GameHistorySatus.normal,
);
