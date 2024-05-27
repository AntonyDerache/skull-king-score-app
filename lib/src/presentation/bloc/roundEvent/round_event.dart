sealed class RoundEvent {
  const RoundEvent();
}

final class StartRound extends RoundEvent {}

final class NextRound extends RoundEvent {}

final class PreviousRound extends RoundEvent {}
