import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_total_score.dart';

import '../../mocks/game_bloc_mocks.dart';

void main() {
  group(GetTotalScore, () {
    test('Get total score round 2', () {
      // GIVEN
      Player player = Player(UniqueKey(), score: 10, name: "a");
      Round round = const Round(2);
      PlayerRoundScore players = PlayerRoundScore.init(
          player.id, player.score, 0, 0, mockEmptyBonusMap);
      int expectedScore = 30;
      // WHEN
      int playerTotalScore = GetTotalScore.execute(round, players);
      // THEN
      expect(playerTotalScore, expectedScore);
    });

    test('Get total score round 10 with bonuses', () {
      // GIVEN
      Player player = Player(UniqueKey(), score: 170, name: "a");
      Round round = const Round(10);
      PlayerRoundScore players = PlayerRoundScore.init(
        player.id,
        player.score,
        3,
        3,
        const {
          BonusKey.pirate: Bonus(30, 1),
          BonusKey.mermaid: Bonus(20, 1),
          BonusKey.skullKing: Bonus(40),
          BonusKey.tenPoints: Bonus(10),
          BonusKey.alliance: Bonus(20),
          BonusKey.rascalBet: Bonus(10),
        },
      );
      int expectedScore = 280;
      // WHEN
      int playerTotalScore = GetTotalScore.execute(round, players);
      // THEN
      expect(playerTotalScore, expectedScore);
    });

    test('Get total score round 5 as negative', () {
      // GIVEN
      Player player = Player(UniqueKey(), score: -40, name: "a");
      Round round = const Round(5);
      PlayerRoundScore players = PlayerRoundScore.init(
          player.id, player.score, 0, 3, mockEmptyBonusMap);
      int expectedScore = -90;
      // WHEN
      int playerTotalScore = GetTotalScore.execute(round, players);
      // THEN
      expect(playerTotalScore, expectedScore);
    });
  });
}
