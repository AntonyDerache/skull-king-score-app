import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/app.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';
import 'package:skull_king_score_app/src/presentation/views/home/home.dart';

import '../createWidgetUnderTest.dart';

void main() {
  late RoundScoreCubit roundScoreCubit;
  late GameBloc gameBloc;
  late PlayerCubit playerCubit;

  setUp(() {
    roundScoreCubit = RoundScoreCubit();
    gameBloc = GameBloc();
    playerCubit = PlayerCubit();
  });

  testWidgets("App initialized correctly", (WidgetTester tester) async {
    // GIVEN
    MainApp mainApp = const MainApp();

    // WHEN
    await tester.pumpWidget(mainApp);

    // THEN
    expect(find.text('Skull King'), findsOneWidget);
    expect(find.text('2 / 8 players'), findsOneWidget);
    final playersList =
        tester.firstWidget<AnimatedList>(find.byType(AnimatedList));
    expect(playersList.initialItemCount, equals(2));
    expect(find.byKey(const ValueKey("start_btn")), findsOneWidget);
  });

  group("Home page", () {
    Widget buildApp() {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: gameBloc),
        BlocProvider.value(value: roundScoreCubit),
        BlocProvider.value(value: playerCubit),
      ], child: createWidgetUnderTest(const Home()));
    }

    testWidgets("add new players then remove them",
        (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());

      final btnAddPlayer = find.byKey(const ValueKey('btn_add_player'));
      final btnRemovePlayer = find.byKey(const ValueKey('btn_remove_player'));

      // WHEN
      await tester.tap(btnAddPlayer);
      await tester.tap(btnAddPlayer);
      await tester.pumpAndSettle();

      AnimatedList playersTextFields =
          tester.firstWidget<AnimatedList>(find.byType(AnimatedList));

      // THEN
      expect(find.text('4 / 8 players'), findsOneWidget);
      expect(playersTextFields.initialItemCount, equals(4));

      // WHEN
      await tester.tap(btnRemovePlayer);
      await tester.tap(btnRemovePlayer);
      await tester.pumpAndSettle();

      playersTextFields =
          tester.firstWidget<AnimatedList>(find.byType(AnimatedList));

      // THEN
      expect(find.text('2 / 8 players'), findsOneWidget);
      expect(playersTextFields.initialItemCount, equals(2));
    });

    testWidgets("show alert if a player's name is missing and dissmiss",
        (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());

      final Finder btnAddPlayer = find.byKey(const ValueKey('btn_add_player'));

      final Finder listItemPlayer1 =
          find.byKey(ValueKey('${playerCubit.state.players[0].id}_name_input'));
      final Finder textFieldPlayer1 = find.descendant(
          of: listItemPlayer1, matching: find.byType(TextField));

      await tester.tap(btnAddPlayer);
      await tester.pumpAndSettle();

      final Finder listItemPlayer2 =
          find.byKey(ValueKey('${playerCubit.state.players[2].id}_name_input'));
      final Finder textFieldPlayer2 = find.descendant(
          of: listItemPlayer2, matching: find.byType(TextField));

      await tester.tap(textFieldPlayer1);
      await tester.enterText(textFieldPlayer1, 'a');
      await tester.pumpAndSettle();
      await tester.tap(textFieldPlayer2);
      await tester.enterText(textFieldPlayer2, 'b');
      await tester.pumpAndSettle();

      // WHEN
      final Finder startBtn = find.byKey(const ValueKey('start_btn'));
      await tester.tap(startBtn);
      await tester.pumpAndSettle();

      // THEN
      expect(find.byKey(const ValueKey('alert_dialog')), findsOneWidget);
      final Finder alertNoBtn = find.byKey(const ValueKey('alert_dialog_no'));
      await tester.tap(alertNoBtn);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('alert_dialog')), findsNothing);
    });

    testWidgets("show alert if less than 2 names are filled in",
        (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      // WHEN
      final Finder startBtn = find.byKey(const ValueKey('start_btn'));
      await tester.tap(startBtn);
      await tester.pumpAndSettle();

      // THEN
      expect(find.byKey(const ValueKey('snackbar')), findsOneWidget);
    });
  });
}
