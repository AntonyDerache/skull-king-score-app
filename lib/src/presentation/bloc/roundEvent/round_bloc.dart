import 'package:bloc/bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/roundEvent/round_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/roundEvent/round_state.dart';

class RoundBloc extends Bloc<RoundEvent, RoundState> {
  RoundBloc() : super(RoundState(0)) {
    on<StartRound>(onStartRound);
    on<NextRound>(onNextRound);
    on<PreviousRound>(onPreviousRound);
  }

  void onStartRound(StartRound event, Emitter<RoundState> emit) {
    emit(RoundState(1));
  }

  void onNextRound(NextRound event, Emitter<RoundState> emit) {
    emit(RoundState(state.round + 1));
  }

  void onPreviousRound(PreviousRound event, Emitter<RoundState> emit) {
    emit(RoundState(state.round - 1));
  }
}
