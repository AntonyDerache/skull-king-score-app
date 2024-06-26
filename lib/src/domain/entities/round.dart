import 'package:equatable/equatable.dart';

class Round extends Equatable {
  final int round;

  const Round(this.round);

  int getValue() {
    return round;
  }

  @override
  String toString() {
    return round.toString();
  }

  @override
  bool operator ==(Object other) {
    return other is Round && round == other.round;
  }

  @override
  int get hashCode => Object.hash(round, null);

  @override
  List<Object?> get props => [round];
}
