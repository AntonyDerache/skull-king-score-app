import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skull_king_score_app/src/app.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/get_player_round_score.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text_field.dart';

import '../test/mocks/game_bloc_mocks.dart';
import 'creaeWidgetUnderTest.dart';

class MockGameBloc extends MockBloc<GameEvent, GameState> implements GameBloc {}

class MockRoundScoreCubit extends MockCubit<List<PlayerRoundScore>>
    implements RoundScoreCubit {}

// how to put key as props in children
void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Add new players", (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Skull King'), findsOneWidget);

    final btnAddPlayer = find.byKey(const ValueKey('btn_add_player'));

    expect(find.text('2 / 8 players'), findsOneWidget);

    await tester.tap(btnAddPlayer);
    await tester.tap(btnAddPlayer);

    await tester.pumpAndSettle();

    final playersList =
        tester.firstWidget<AnimatedList>(find.byType(AnimatedList));

    expect(find.text('4 / 8 players'), findsOneWidget);
    expect(playersList.initialItemCount, equals(4));
    final textInputs = find.byType(SKTextInput);
    // how to access text of an input
    expect(textInputs, findsNWidgets(4));

    final startBtn = find.byKey(const ValueKey('test'));

    // how to mock functions
    expect(startBtn, findsOneWidget);
  });

  group('Game view round one', () {
    late RoundScoreCubit roundScoreCubit;
    late GameBloc gameBloc;

    setUp(() {
      roundScoreCubit = RoundScoreCubit();
      gameBloc = GameBloc();
      gameBloc.add(GameStarted(
        List.from(mockPlayers),
      ));
      roundScoreCubit.setFrom(
          List.generate(2, (idx) => PlayerRoundScore(mockPlayers[idx].id, 0)));
    });

    testWidgets("scoreboard is expanding", (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: gameBloc),
            BlocProvider.value(value: roundScoreCubit),
          ],
          child: createWidgetUnderTest(const Game()),
        ),
      );

      expect(find.text('Skull King'), findsNothing);

      final scoreAppBar = find.byKey(const ValueKey('score_app_bar'));

      expect(find.byKey(const ValueKey('scoreboard_unexpanded'),),
          findsOneWidget);

      await tester.tap(scoreAppBar);
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('scoreboard_expanded')),
          findsOneWidget);
    });
  });
}
