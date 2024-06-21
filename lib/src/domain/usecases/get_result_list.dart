import 'package:skull_king_score_app/src/domain/entities/player.dart';

class GetResultList {
  static List<Player> execute(List<Player> players) {
    List<Player> resultList = List.from(players);
    resultList.sort((a, b) => b.score.compareTo(a.score));
    return resultList;
  }
}
