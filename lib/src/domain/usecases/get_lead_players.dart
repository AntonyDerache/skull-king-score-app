import 'package:skull_king_score_app/src/domain/entities/player.dart';

class GetLeadPlayers {
  static List<Player> execute(List<Player> players) {
    int higherScore = players
        .reduce((currentPlayer, nextPlayer) =>
            currentPlayer.score > nextPlayer.score ? currentPlayer : nextPlayer)
        .score;

    List<Player> leadPlayers = List.empty(growable: true);

    for (var element in players) {
      if (element.score == higherScore) {
        leadPlayers.add(element);
      }
    }
    return leadPlayers;
  }
}
