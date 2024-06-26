import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_lead_players.dart';

void main() {
  group(GetLeadPlayers, () {
    test('Get lead player', () {
      // GIVEN
      Player player1 = Player(UniqueKey(), score: 10, name: "a");
      Player player2 = Player(UniqueKey(), score: 20, name: "b");
      Player player3 = Player(UniqueKey(), score: 30, name: "c");
      Player player4 = Player(UniqueKey(), score: 70, name: "d");
      List<Player> players = [player1, player2, player3, player4];
      List<Player> expectedLeadPlayers = [player4];
      // WHEN
      List<Player> leadPlayers = GetLeadPlayers.execute(players);
      // THEN
      expect(listEquals(leadPlayers, expectedLeadPlayers), true);
    });

    test('Get multiple lead players', () {
      // GIVEN
      Player player1 = Player(UniqueKey(), score: 30, name: "a");
      Player player2 = Player(UniqueKey(), score: 10, name: "b");
      Player player3 = Player(UniqueKey(), score: 80, name: "c");
      Player player4 = Player(UniqueKey(), score: 80, name: "d");
      List<Player> players = [player1, player2, player3, player4];
      List<Player> expectedLeadPlayers = [player3, player4];
      // WHEN
      List<Player> leadPlayers = GetLeadPlayers.execute(players);
      // THEN
      expect(listEquals(leadPlayers, expectedLeadPlayers), true);
    });
  });
}
