import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_result_list.dart';

void main() {
  group(GetResultList, () {
    test('Get result list', () {
      // GIVEN
      Player player1 = Player(UniqueKey(), score: 10, name: "a");
      Player player2 = Player(UniqueKey(), score: 70, name: "b");
      Player player3 = Player(UniqueKey(), score: 30, name: "c");
      Player player4 = Player(UniqueKey(), score: 50, name: "d");

      List<Player> players = [player1, player2, player3, player4];
      List<Player> expectedOrder = [player2, player4, player3, player1];
      // WHEN
      List<Player> resultList = GetResultList.execute(players);
      // THEN
      expect(resultList, equals(expectedOrder));
    });

    test('Get result list with equality', () {
      // GIVEN
      Player player1 = Player(UniqueKey(), score: 30, name: "a");
      Player player2 = Player(UniqueKey(), score: 70, name: "b");
      Player player3 = Player(UniqueKey(), score: 30, name: "c");
      Player player4 = Player(UniqueKey(), score: 50, name: "d");

      List<Player> players = [player1, player2, player3, player4];
      List<Player> expectedOrder = [player2, player4, player1, player3];
      // WHEN
      List<Player> resultList = GetResultList.execute(players);
      // THEN
      expect(resultList, equals(expectedOrder));
    });
  });
}
