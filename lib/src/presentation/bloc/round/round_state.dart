import 'package:equatable/equatable.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';

class RoundState extends Equatable {
  final Round round;

  const RoundState(this.round);

  @override
  String toString() {
    return 'Current round: ${round.getValue()}';
  }

  @override
  List<Object?> get props => [round];
}
