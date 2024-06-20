import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';

class GetResultList {
  static List<PlayerState> execute(List<PlayerState> players) {
    List<PlayerState> resultList = List.from(players);
    resultList.sort((a, b) => b.score.compareTo(a.score));
    return resultList;
  }
}
