import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_event.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game.dart';
import 'package:skull_king_score_app/src/presentation/views/home/home.dart';

import '../createWidgetUnderTest.dart';

void main() {
  late LanguageCubit languageCubit;
  late PlayerCubit playerCubit;

  setUp(() {
    playerCubit = PlayerCubit();
    languageCubit = LanguageCubit(const EnglishLanguageState());
  });

  testWidgets("Open drawer from game view", (WidgetTester tester) async {
    // GIVEN
    final List<Player> mockPlayers = [
      Player(UniqueKey(), name: "a", score: 0),
      Player(UniqueKey(), name: "b", score: 0),
    ];
    final RoundScoreCubit roundScoreCubit = RoundScoreCubit();
    final GameBloc gameBloc = GameBloc();
    gameBloc.add(GameStarted(mockPlayers));
    roundScoreCubit.setFrom(List.generate(
        mockPlayers.length, (idx) => PlayerRoundScore(mockPlayers[idx].id, 0)));
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: gameBloc),
          BlocProvider.value(value: roundScoreCubit),
          BlocProvider.value(value: languageCubit),
        ],
        child: createWidgetUnderTest(const Game(), initialRoute: gameUrl),
      ),
    );
    final Finder openDrawerGameBtn =
        find.byKey(const ValueKey("open_drawer_game_btn"));

    // WHEN
    await tester.tap(openDrawerGameBtn);
    await tester.pumpAndSettle();

    // THEN
    expect(find.byKey(const ValueKey("drawer")), findsOneWidget);
    expect(find.byKey(const ValueKey("drawer_rules_btn")), findsOneWidget);
    expect(find.byKey(const ValueKey("drawer_help_btn")), findsOneWidget);
    expect(find.byKey(const ValueKey("drawer_home_btn")), findsOneWidget);
  });

  group('from home page', () {
    Widget buildApp() {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: languageCubit),
          BlocProvider.value(value: playerCubit),
        ],
        child: createWidgetUnderTest(const Home()),
      );
    }

    testWidgets("Open drawer from home view", (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());
      final Finder openDrawerHomeBtn =
          find.byKey(const ValueKey("open_drawer_home_btn"));

      // WHEN
      await tester.tap(openDrawerHomeBtn);
      await tester.pumpAndSettle();

      // THEN
      expect(find.byKey(const ValueKey("drawer")), findsOneWidget);
      expect(find.byKey(const ValueKey("drawer_rules_btn")), findsOneWidget);
      expect(find.byKey(const ValueKey("drawer_help_btn")), findsOneWidget);
      expect(find.byKey(const ValueKey("drawer_home_btn")), findsNothing);
    });

    testWidgets("change language", (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());
      final Finder openDrawerHomeBtn =
          find.byKey(const ValueKey("open_drawer_home_btn"));
      await tester.tap(openDrawerHomeBtn);
      await tester.pumpAndSettle();
      final Finder languageDropdownBtn =
          find.byKey(const ValueKey("language_dropdown"));

      // WHEN
      await tester.tap(languageDropdownBtn);
      await tester.pumpAndSettle();
      final Finder languageDropdownBtnFr =
          find.byKey(const ValueKey("language_dropdown_item_fr"));
      await tester.tap(languageDropdownBtnFr);
      await tester.pumpAndSettle();

      // THEN
      expect(languageCubit.state, isA<FrenchLanguageState>());
    });

    testWidgets("open help", (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());
      final Finder openDrawerHomeBtn =
          find.byKey(const ValueKey("open_drawer_home_btn"));

      // WHEN
      await tester.tap(openDrawerHomeBtn);
      await tester.pumpAndSettle();

      final Finder drawerHelpBtn =
          find.byKey(const ValueKey("drawer_help_btn"));
      await tester.tap(drawerHelpBtn);
      await tester.pumpAndSettle();
      // THEN
      expect(find.byKey(const ValueKey("drawer_help_modal")), findsOneWidget);

      // WHEN
      final Finder drawerHelpMmdalBackBtn =
          find.byKey(const ValueKey("drawer_help_modal_back_btn"));
      await tester.tap(drawerHelpMmdalBackBtn);
      await tester.pumpAndSettle();

      // THEN
      expect(find.byKey(const ValueKey("drawer_help_modal")), findsNothing);
    });
  });
}
