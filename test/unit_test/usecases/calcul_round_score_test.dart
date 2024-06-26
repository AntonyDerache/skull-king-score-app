import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/usecases/calcul_round_score.dart';

import '../../mocks/game_bloc_mocks.dart';

void main() {
  group(CalculRoundScore, () {
    test('Calcul success round score with bids', () {
      // GIVEN
      Round round = const Round(1);
      PlayerRoundScore playerRoundScore =
          PlayerRoundScore.init(UniqueKey(), 0, 2, 2, mockEmptyBonusMap);
      int expectedScore = 40;
      // WHEN
      int roundScore = CalculRoundScore.execute(round, playerRoundScore);
      // THEN
      expect(roundScore, expectedScore);
    });

    test('Calcul failed round score with 2 of differences bids - tricksWon',
        () {
      // GIVEN
      Round round = const Round(2);
      PlayerRoundScore playerRoundScore =
          PlayerRoundScore.init(UniqueKey(), 0, 2, 4, mockEmptyBonusMap);
      int expectedScore = -20;
      // WHEN
      int roundScore = CalculRoundScore.execute(round, playerRoundScore);
      // THEN
      expect(roundScore, expectedScore);
    });

    test('Calcul success round score with 0 bids', () {
      // GIVEN
      Round round = const Round(8);
      PlayerRoundScore playerRoundScore =
          PlayerRoundScore.init(UniqueKey(), 0, 0, 0, mockEmptyBonusMap);
      int expectedScore = 80;
      // WHEN
      int roundScore = CalculRoundScore.execute(round, playerRoundScore);
      // THEN
      expect(roundScore, expectedScore);
    });

    test('Calcul failed round score with 0 bids', () {
      // GIVEN
      Round round = const Round(4);
      PlayerRoundScore playerRoundScore =
          PlayerRoundScore.init(UniqueKey(), 0, 0, 1, mockEmptyBonusMap);
      int expectedScore = -40;
      // WHEN
      int roundScore = CalculRoundScore.execute(round, playerRoundScore);
      // THEN
      expect(roundScore, expectedScore);
    });

    test('Calcul failed round score with bids and bonus', () {
      // GIVEN
      Map<BonusKey, Bonus> mockEmptyBonusMap = {
        BonusKey.pirate: const Bonus(30, 2),
        BonusKey.mermaid: const Bonus(20),
        BonusKey.skullKing: const Bonus(40),
        BonusKey.tenPoints: const Bonus(10, 1),
        BonusKey.alliance: const Bonus(20),
        BonusKey.rascalBet: const Bonus(10),
      };
      Round round = const Round(3);
      PlayerRoundScore playerRoundScore =
          PlayerRoundScore.init(UniqueKey(), 0, 1, 4, mockEmptyBonusMap);
      int expectedScore = -30;
      // WHEN
      int roundScore = CalculRoundScore.execute(round, playerRoundScore);
      // THEN
      expect(roundScore, expectedScore);
    });

    test('Calcul success round score with bids with bonus', () {
      // GIVEN
      Map<BonusKey, Bonus> mockEmptyBonusMap = {
        BonusKey.pirate: const Bonus(30, 2),
        BonusKey.mermaid: const Bonus(20),
        BonusKey.skullKing: const Bonus(40),
        BonusKey.tenPoints: const Bonus(10, 1),
        BonusKey.alliance: const Bonus(20),
        BonusKey.rascalBet: const Bonus(10),
      };
      Round round = const Round(3);
      PlayerRoundScore playerRoundScore =
          PlayerRoundScore.init(UniqueKey(), 0, 4, 4, mockEmptyBonusMap);
      int expectedScore = 150;
      // WHEN
      int roundScore = CalculRoundScore.execute(round, playerRoundScore);
      // THEN
      expect(roundScore, expectedScore);
    });

    test('Calcul success round score with bids with rascal bet', () {
      // GIVEN
      Map<BonusKey, Bonus> mockEmptyBonusMap = {
        BonusKey.pirate: const Bonus(30),
        BonusKey.mermaid: const Bonus(20),
        BonusKey.skullKing: const Bonus(40),
        BonusKey.tenPoints: const Bonus(10),
        BonusKey.alliance: const Bonus(20),
        BonusKey.rascalBet: const Bonus(10, 2),
      };
      Round round = const Round(3);
      PlayerRoundScore playerRoundScore =
          PlayerRoundScore.init(UniqueKey(), 0, 4, 4, mockEmptyBonusMap);
      int expectedScore = 100;
      // WHEN
      int roundScore = CalculRoundScore.execute(round, playerRoundScore);
      // THEN
      expect(roundScore, expectedScore);
    });

    test('Calcul failed round score with bids with rascal bet', () {
      // GIVEN
      Map<BonusKey, Bonus> mockEmptyBonusMap = {
        BonusKey.pirate: const Bonus(30),
        BonusKey.mermaid: const Bonus(20),
        BonusKey.skullKing: const Bonus(40),
        BonusKey.tenPoints: const Bonus(10),
        BonusKey.alliance: const Bonus(20),
        BonusKey.rascalBet: const Bonus(10, 2),
      };
      Round round = const Round(3);
      PlayerRoundScore playerRoundScore =
          PlayerRoundScore.init(UniqueKey(), 0, 2, 4, mockEmptyBonusMap);
      int expectedScore = -40;
      // WHEN
      int roundScore = CalculRoundScore.execute(round, playerRoundScore);
      // THEN
      expect(roundScore, expectedScore);
    });
  });
}
