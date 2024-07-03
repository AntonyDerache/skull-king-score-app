import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/presentation/utils/list_utils.dart';

void main() {
  test('areListsNotEquals is true', () {
    // GIVEN
    List<Player> list1 = [
      Player(UniqueKey(), name: 'c', score: 10),
      Player(UniqueKey(), name: 'd', score: 29),
    ];
    List<Player> list2 = [
      Player(UniqueKey(), name: 'a', score: 30),
      Player(UniqueKey(), name: 'b', score: 20),
    ];

    // WHEN
    final result = ListUtils.areListsNotEquals(list1, list2);

    // THEN
    expect(result, isTrue);
  });

  test('areListsNotEquals is false', () {
    // GIVEN
    Player player1 = Player(UniqueKey(), name: 'c', score: 10);
    Player player2 = Player(UniqueKey(), name: 'd', score: 29);
    List<Player> list1 = [
      player1,
      player2,
    ];
    List<Player> list2 = [
      player1,
      player2,
    ];

    // WHEN
    final result = ListUtils.areListsNotEquals(list1, list2);

    // THEN
    expect(result, isFalse);
  });
}
