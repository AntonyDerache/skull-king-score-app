import 'package:bloc/bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_state.dart';

class RoundBloc extends Bloc<RoundEvent, RoundState> {
  RoundBloc() : super(RoundState(Round(0))) {
    on<StartRound>(onStartRound);
    on<NextRound>(onNextRound);
    on<PreviousRound>(onPreviousRound);
  }

  void onStartRound(StartRound event, Emitter<RoundState> emit) {
    emit(RoundState(Round(1)));
  }

  void onNextRound(NextRound event, Emitter<RoundState> emit) {
    emit(RoundState(Round(state.round.getValue() + 1)));
  }

  void onPreviousRound(PreviousRound event, Emitter<RoundState> emit) {
    emit(RoundState(Round(state.round.getValue() - 1)));
  }
}
