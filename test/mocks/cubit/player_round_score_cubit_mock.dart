import 'package:bloc_test/bloc_test.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';

class MockRoundScoreCubit extends MockCubit<List<PlayerRoundScore>>
    implements RoundScoreCubit {}
