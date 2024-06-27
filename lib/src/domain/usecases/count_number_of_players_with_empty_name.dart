import 'package:skull_king_score_app/src/domain/entities/player.dart';

class CountNumberOfPlayersWithFilledName {
  static int execute(List<Player> players) {
    int numberOfPlayersWithName = 0;

    for (Player player in players) {
      if (player.name.isNotEmpty) {
        numberOfPlayersWithName++;
      }
    }
    return numberOfPlayersWithName;
  }
}
