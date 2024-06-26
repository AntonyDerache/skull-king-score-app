import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_total_tricks_won.dart';

import '../../mocks/game_bloc_mocks.dart';

void main() {
  group(GetTotalTricksWon, () {
    test('Get total tricks won score', () {
      // GIVEN
      List<PlayerRoundScore> scores = [
        PlayerRoundScore.init(UniqueKey(), 0, 0, 6, mockEmptyBonusMap),
        PlayerRoundScore.init(UniqueKey(), 0, 0, 2, mockEmptyBonusMap),
      ];
      int expectedTotalTricksWon = 8;
      // WHEN
      int totalTricksWon = GetTotalTricksWon.execute(scores);
      // THEN
      expect(totalTricksWon, expectedTotalTricksWon);
    });
  });
}
