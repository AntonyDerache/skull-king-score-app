import 'package:equatable/equatable.dart';

enum BonusKey { pirate, mermaid, skullKing, tenPoints, alliance, rascalBet }

class Bonus extends Equatable {
  final int value;
  final int amount;

  const Bonus(this.value, [this.amount = 0]);

  @override
  String toString() {
    return "$amount";
  }

  @override
  List<Object?> get props => [value, amount];
}
