import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';

class GetLeadPlayers {
  static List<PlayerState> execute(List<PlayerState> players) {
    int higherScore = players
        .reduce((currentPlayer, nextPlayer) =>
            currentPlayer.score > nextPlayer.score ? currentPlayer : nextPlayer)
        .score;

    List<PlayerState> leadPlayers = List.empty(growable: true);

    for (var element in players) {
      if (element.score == higherScore) {
        leadPlayers.add(element);
      }
    }
    return leadPlayers;
  }
}
