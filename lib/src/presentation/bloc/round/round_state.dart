import 'package:skull_king_score_app/src/domain/entities/round.dart';

class RoundState {
  Round round;

  RoundState(this.round);

  @override
  String toString() {
    return 'Current round: ${round.getValue()}';
  }
}
