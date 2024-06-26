import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';

void main() {
  group(RoundScoreCubit, () {
    test('Round Score Cubit initial state is correct', () {
      // GIVEN
      // WHEN
      RoundScoreCubit roundScoreCubit = RoundScoreCubit();
      // THEN
      expect(roundScoreCubit.state.isEmpty, true);
    });

    group('setFrom', () {
      test('using setFrom with an empty state', () {
        // GIVEN
        RoundScoreCubit roundScoreCubit = RoundScoreCubit();

        List<PlayerRoundScore> otherList =
            List.generate(1, (_) => PlayerRoundScore(UniqueKey(), 0));
        // WHEN
        roundScoreCubit.setFrom(otherList);
        // THEN
        expect(roundScoreCubit.state.length, 1);
      });

      test('using setFrom to replace existing state', () {
        // GIVEN
        RoundScoreCubit roundScoreCubit = RoundScoreCubit();
        List<PlayerRoundScore> existingList =
            List.generate(1, (_) => PlayerRoundScore(UniqueKey(), 0));
        List<PlayerRoundScore> otherList =
            List.generate(2, (_) => PlayerRoundScore(UniqueKey(), 0));
        // WHEN
        roundScoreCubit.setFrom(existingList);
        roundScoreCubit.setFrom(otherList);
        // THEN
        expect(roundScoreCubit.state.length, 2);
        expect(roundScoreCubit.state, isNot(existingList));
      });
    });

    test('increase value of bonus when pressed', () {
      // GIVEN
      RoundScoreCubit roundScoreCubit = RoundScoreCubit();
      UniqueKey playerId = UniqueKey();
      BonusKey bonusKey = BonusKey.pirate;
      int amount = 2;
      List<PlayerRoundScore> list =
          List.generate(1, (_) => PlayerRoundScore(playerId, 0));
      // WHEN
      roundScoreCubit.setFrom(list);
      roundScoreCubit.onBonusPressed(playerId, bonusKey, amount);
      Bonus bonus = roundScoreCubit.state[0].bonusPoints[bonusKey] as Bonus;
      // THEN
      expect(bonus, isNotNull);
      expect(bonus.amount, amount);
    });

    test('update value of bids', () {
      // GIVEN
      RoundScoreCubit roundScoreCubit = RoundScoreCubit();
      UniqueKey playerId = UniqueKey();
      String value = "2";
      List<PlayerRoundScore> list =
          List.generate(1, (_) => PlayerRoundScore(playerId, 0));
      // WHEN
      roundScoreCubit.setFrom(list);
      roundScoreCubit.onBidsChanged(playerId, value);
      // THEN
      expect(roundScoreCubit.state[0].bids, 2);
    });

    test('update value of tricks', () {
      // GIVEN
      RoundScoreCubit roundScoreCubit = RoundScoreCubit();
      UniqueKey playerId = UniqueKey();
      String value = "2";
      List<PlayerRoundScore> list =
          List.generate(1, (_) => PlayerRoundScore(playerId, 0));
      // WHEN
      roundScoreCubit.setFrom(list);
      roundScoreCubit.onWonTricksChanged(playerId, value);
      // THEN
      expect(roundScoreCubit.state[0].tricksWon, 2);
    });
  });
}
