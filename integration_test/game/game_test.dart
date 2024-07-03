import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/utils/get_player_round_score.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_scoreboard.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_number_field.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

import '../../test/mocks/bloc/game_bloc_mock.dart';
import '../../test/mocks/cubit/player_round_score_cubit_mock.dart';
import '../../test/mocks/game_bloc_data_mocks.dart';
import '../createWidgetUnderTest.dart';

void main() {
  late RoundScoreCubit roundScoreCubit;
  late GameBloc gameBloc;

  group("Game page at round 1", () {
    late List<Player> mockPlayers;

    setUp(() {
      roundScoreCubit = RoundScoreCubit();
      gameBloc = GameBloc();
    });

    Widget buildApp() {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: gameBloc),
          BlocProvider.value(value: roundScoreCubit),
        ],
        child: createWidgetUnderTest(const Game(), initialRoute: gameUrl),
      );
    }

    setUp(() {
      mockPlayers = [
        Player(UniqueKey(), name: "a", score: 0),
        Player(UniqueKey(), name: "b", score: 0),
      ];
      gameBloc.add(GameStarted(mockPlayers));
      roundScoreCubit.setFrom(List.generate(mockPlayers.length,
          (idx) => PlayerRoundScore(mockPlayers[idx].id, 0)));
    });

    testWidgets("set bids & tricks & bonuses with bonus reset",
        (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());
      final SKNumberField playerOneBidsBtnWidget = find
          .byKey(ValueKey('${mockPlayers[0].id}_bids_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final SKNumberField playerOneTricksBtnWidget = find
          .byKey(ValueKey('${mockPlayers[0].id}_tricks_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final SKNumberField playerTwoBidsBtnWidget = find
          .byKey(ValueKey('${mockPlayers[1].id}_bids_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;

      final Finder player1PirateBonusIcon =
          find.byKey(ValueKey('${mockPlayers[0].id}_pirate_bonus_icon'));
      final Finder player1PMermaidBonusIcon =
          find.byKey(ValueKey('${mockPlayers[0].id}_mermaid_bonus_icon'));
      final Finder player1SkullKingBonusIcon =
          find.byKey(ValueKey('${mockPlayers[0].id}_skull_king_bonus_icon'));

      final List<PlayerRoundScore> expectedRoundScore = [
        PlayerRoundScore.init(
            mockPlayers[0].id, 0, 1, 1, mockBonusMapWithOnePirate),
        PlayerRoundScore.init(mockPlayers[1].id, 0, 1, 0, mockEmptyBonusMap),
      ];

      // WHEN
      playerOneBidsBtnWidget.onChange?.call("1");
      playerOneTricksBtnWidget.onChange?.call("1");
      playerTwoBidsBtnWidget.onChange?.call("1");

      await tester.tap(player1PirateBonusIcon);
      await tester.tap(player1PMermaidBonusIcon);
      await tester.tap(player1SkullKingBonusIcon);
      await tester.pumpAndSettle();
      await tester.tap(player1SkullKingBonusIcon);
      await tester.longPress(player1PMermaidBonusIcon);
      await tester.pumpAndSettle();

      final SKText previewScorePlayer1 = find
          .byKey(ValueKey("${mockPlayers[0].id}_score_preview"))
          .evaluate()
          .single
          .widget as SKText;
      final SKText previewScorePlayer2 = find
          .byKey(ValueKey("${mockPlayers[1].id}_score_preview"))
          .evaluate()
          .single
          .widget as SKText;

      // THEN
      expect(roundScoreCubit.state, equals(expectedRoundScore));
      expect(previewScorePlayer1.text, equals(" +50"));
      expect(previewScorePlayer2.text, equals(" -10"));
    });

    testWidgets("add all bonuses", (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());
      final Finder player1PirateBonusIcon =
          find.byKey(ValueKey('${mockPlayers[0].id}_pirate_bonus_icon'));
      final Finder player1MermaidBonusIcon =
          find.byKey(ValueKey('${mockPlayers[0].id}_mermaid_bonus_icon'));
      final Finder player1SkullBonusIcon =
          find.byKey(ValueKey('${mockPlayers[0].id}_skull_king_bonus_icon'));
      final Finder player1TenBonusIcon =
          find.byKey(ValueKey('${mockPlayers[0].id}_ten_bonus_icon'));
      final Finder player1AllianceBonusIcon =
          find.byKey(ValueKey('${mockPlayers[0].id}_alliance_bonus_icon'));
      final Finder player1BetBonusIcon =
          find.byKey(ValueKey('${mockPlayers[0].id}_bet_bonus_icon'));
      final List<PlayerRoundScore> expectedRoundScore = [
        PlayerRoundScore.init(
            mockPlayers[0].id, 0, 0, 0, mockBonusMapWithOneOfEach),
        PlayerRoundScore.init(mockPlayers[1].id, 0, 0, 0, mockEmptyBonusMap),
      ];

      // WHEN
      await tester.tap(player1PirateBonusIcon);
      await tester.tap(player1MermaidBonusIcon);
      await tester.tap(player1SkullBonusIcon);
      await tester.tap(player1TenBonusIcon);
      await tester.tap(player1AllianceBonusIcon);
      await tester.tap(player1BetBonusIcon);

      // THEN
      expect(roundScoreCubit.state, expectedRoundScore);
    });

    testWidgets("does krakren been played?", (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());
      final Finder endRoundBtn =
          find.byKey(const ValueKey("game_end_round_btn"));

      // WHEN
      await tester.tap(endRoundBtn);
      await tester.pumpAndSettle();

      // THEN
      expect(find.byKey(const ValueKey('alert_dialog')), findsOneWidget);
      final Finder alertNoBtn = find.byKey(const ValueKey('alert_dialog_no'));
      await tester.tap(alertNoBtn);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('alert_dialog')), findsNothing);
    });

    testWidgets("invalid round data (too much round registered)",
        (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());
      final Finder endRoundBtn =
          find.byKey(const ValueKey("game_end_round_btn"));
      final SKNumberField player1BidsBtnWidget = find
          .byKey(ValueKey('${mockPlayers[0].id}_bids_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final SKNumberField player1TricksBtnWidget = find
          .byKey(ValueKey('${mockPlayers[0].id}_tricks_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final SKNumberField player2BidsBtnWidget = find
          .byKey(ValueKey('${mockPlayers[1].id}_bids_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final SKNumberField player2TricksBtnWidget = find
          .byKey(ValueKey('${mockPlayers[1].id}_tricks_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;

      // WHEN
      player1BidsBtnWidget.onChange?.call("1");
      player1TricksBtnWidget.onChange?.call("1");
      player2BidsBtnWidget.onChange?.call("1");
      player2TricksBtnWidget.onChange?.call("1");
      await tester.tap(endRoundBtn);
      await tester.pumpAndSettle();

      // THEN
      expect(find.byKey(const ValueKey('snackbar')), findsOneWidget);
    });

    testWidgets(
        "back to previous round and check scoreboard updated to previous",
        (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: gameBloc),
            BlocProvider.value(value: roundScoreCubit),
          ],
          child: BlocListener<GameBloc, GameState>(
            listenWhen: (previous, current) => previous.round != current.round,
            listener: (context, state) {
              if (state.round.getValue() > 0) {
                context.read<RoundScoreCubit>().setFrom(
                      getPlayerRoundScore(state.round, state.roundHistory),
                    );
              }
            },
            child: createWidgetUnderTest(const Game(), initialRoute: gameUrl),
          ),
        ),
      );
      final SKNumberField player1BidsBtnWidget = find
          .byKey(ValueKey('${mockPlayers[0].id}_bids_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final SKNumberField player1TricksBtnWidget = find
          .byKey(ValueKey('${mockPlayers[0].id}_tricks_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final Finder endRoundBtn =
          find.byKey(const ValueKey("game_end_round_btn"));
      final Finder backBtn = find.byKey(const ValueKey("game_back_btn"));
      final Finder scoreAppBar = find.byKey(const ValueKey('score_app_bar'));

      final List<Player> expectedPlayersValue = [
        Player(mockPlayers[0].id, name: mockPlayers[0].name, score: 20),
        Player(mockPlayers[1].id, name: mockPlayers[1].name, score: 10),
      ];

      // WHEN
      player1BidsBtnWidget.onChange?.call("1");
      player1TricksBtnWidget.onChange?.call("1");
      await tester.tap(endRoundBtn);
      await tester.pumpAndSettle();

      player1BidsBtnWidget.onChange?.call("2");
      player1TricksBtnWidget.onChange?.call("2");
      await tester.tap(endRoundBtn);
      await tester.pumpAndSettle();

      await tester.tap(backBtn);
      await tester.pumpAndSettle();
      await tester.tap(scoreAppBar);
      await tester.pumpAndSettle();

      // THEN
      final Finder scoreboard = find.byKey(const ValueKey('scoreboard'));
      final ScoreBoard scoreboardWidget =
          scoreboard.evaluate().single.widget as ScoreBoard;
      expect(gameBloc.state.round.getValue(), equals(2));
      expect(scoreboardWidget.players, equals(expectedPlayersValue));
    });

    testWidgets("game end round detect history data is behind and changed",
        (WidgetTester tester) async {
      // GIVEN
      await tester.pumpWidget(buildApp());
      final SKNumberField player1BidsBtnWidget = find
          .byKey(ValueKey('${mockPlayers[0].id}_bids_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final SKNumberField player1TricksBtnWidget = find
          .byKey(ValueKey('${mockPlayers[0].id}_tricks_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final SKNumberField player2BidsBtnWidget = find
          .byKey(ValueKey('${mockPlayers[1].id}_bids_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final SKNumberField player2TricksBtnWidget = find
          .byKey(ValueKey('${mockPlayers[1].id}_tricks_btn'))
          .evaluate()
          .single
          .widget as SKNumberField;
      final Finder endRoundBtn =
          find.byKey(const ValueKey("game_end_round_btn"));
      final Finder backBtn = find.byKey(const ValueKey("game_back_btn"));

      final List<PlayerRoundScore> expectedRoundScore = [
        PlayerRoundScore.init(mockPlayers[0].id, 0, 0, 0, mockEmptyBonusMap),
        PlayerRoundScore.init(mockPlayers[1].id, 0, 1, 1, mockEmptyBonusMap),
      ];

      // WHEN
      player1BidsBtnWidget.onChange?.call("1");
      player1TricksBtnWidget.onChange?.call("1");
      await tester.tap(endRoundBtn);
      await tester.pumpAndSettle();

      player1BidsBtnWidget.onChange?.call("2");
      player1TricksBtnWidget.onChange?.call("2");
      await tester.tap(endRoundBtn);
      await tester.pumpAndSettle();

      await tester.tap(backBtn);
      await tester.pumpAndSettle();
      await tester.tap(backBtn);
      await tester.pumpAndSettle();

      player1BidsBtnWidget.onChange?.call("0");
      player1TricksBtnWidget.onChange?.call("0");
      player2BidsBtnWidget.onChange?.call("1");
      player2TricksBtnWidget.onChange?.call("1");
      await tester.pumpAndSettle();
      await tester.tap(endRoundBtn);
      await tester.pumpAndSettle();

      // THEN
      expect(gameBloc.state.round.getValue(), equals(1));
      expect(roundScoreCubit.state, equals(expectedRoundScore));
      expect(find.byKey(const ValueKey('alert_dialog')), findsOneWidget);
      final Finder alertNoBtn = find.byKey(const ValueKey('alert_dialog_no'));
      await tester.tap(alertNoBtn);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('alert_dialog')), findsNothing);
    });
  });

  group('Game page with custom round', () {
    late List<Player> mockPlayers;

    Widget buildApp() {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: gameBloc),
          BlocProvider.value(value: roundScoreCubit),
        ],
        child: createWidgetUnderTest(const Game(), initialRoute: gameUrl),
      );
    }

    testWidgets("scoreboard is expanding", (WidgetTester tester) async {
      // GIVEN
      mockPlayers = [
        Player(UniqueKey(), name: "Toto", score: 0),
        Player(UniqueKey(), name: "Titi", score: 10),
      ];
      roundScoreCubit = MockRoundScoreCubit();
      gameBloc = MockGameBloc();
      final GameState mockGameState = GameState(
        const Round(1),
        playersInGame: List.from(mockPlayers),
        historyStatus: GameHistorySatus.normal,
        roundHistory: const [[]],
      );
      final mockRoundScoreCubitState = List.generate(mockPlayers.length,
          (idx) => PlayerRoundScore(mockPlayers[idx].id, idx * 10));

      when(() => gameBloc.state).thenReturn(mockGameState);
      when(() => roundScoreCubit.state).thenReturn(mockRoundScoreCubitState);
      await tester.pumpWidget(buildApp());
      final SKPlayerTitle leadPlayer = find
          .byKey(const ValueKey("lead_player"))
          .evaluate()
          .first
          .widget as SKPlayerTitle;

      final SKText leadPlayerSore = find
          .byKey(const ValueKey("lead_player_score"))
          .evaluate()
          .first
          .widget as SKText;

      // WHEN
      final Finder scoreAppBar = find.byKey(const ValueKey('score_app_bar'));

      // THEN
      expect(
          find.byKey(const ValueKey('scoreboard_unexpanded')), findsOneWidget);

      // WHEN
      await tester.tap(scoreAppBar);
      await tester.pumpAndSettle();

      final Finder scoreboardGridView =
          find.byKey(const ValueKey('scoreboard_expanded'));
      final Finder gridViewItems =
          find.byKey(const ValueKey('scoreboard_grid_item'));

      // THEN
      expect(leadPlayer.playerName, equals("Titi"));
      expect(leadPlayerSore.text, equals(": 10"));
      expect(scoreboardGridView, findsOneWidget);
      expect(gridViewItems.evaluate().length, 2);
    });

    testWidgets("scoreboard is updating", (WidgetTester tester) async {
      // GIVEN
      mockPlayers = [
        Player(UniqueKey(), name: "a", score: 0),
        Player(UniqueKey(), name: "b", score: 0),
        Player(UniqueKey(), name: "c", score: 0),
      ];
      roundScoreCubit = RoundScoreCubit();
      gameBloc = GameBloc();
      gameBloc.add(GameStarted(List.from(mockPlayers)));
      roundScoreCubit.setFrom(List.generate(mockPlayers.length,
          (idx) => PlayerRoundScore(mockPlayers[idx].id, 0)));
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: gameBloc),
            BlocProvider.value(value: roundScoreCubit),
          ],
          child: BlocListener<GameBloc, GameState>(
            listenWhen: (previous, current) => previous.round != current.round,
            listener: (context, state) {
              if (state.round.getValue() > 0) {
                context.read<RoundScoreCubit>().setFrom(
                      getPlayerRoundScore(state.round, state.roundHistory),
                    );
              }
            },
            child: createWidgetUnderTest(const Game(), initialRoute: gameUrl),
          ),
        ),
      );
      final scoreAppBar = find.byKey(const ValueKey('score_app_bar'));
      final List<PlayerRoundScore> endRoundPlayersScores = [
        PlayerRoundScore(mockPlayers[0].id, 0,
            bids: 0, tricksWon: 0, bonusPoints: mockEmptyBonusMap),
        PlayerRoundScore(mockPlayers[1].id, 0,
            bids: 1, tricksWon: 0, bonusPoints: mockEmptyBonusMap),
        PlayerRoundScore(mockPlayers[2].id, 0,
            bids: 1, tricksWon: 1, bonusPoints: mockEmptyBonusMap),
      ];
      final List<PlayerRoundScore> endRound2PlayersScores = [
        endRoundPlayersScores[0].copyWith(currentScore: 10, tricksWon: 1),
        endRoundPlayersScores[1]
            .copyWith(currentScore: -10, bids: 2, tricksWon: 2),
        endRoundPlayersScores[2]
            .copyWith(currentScore: 20, bids: 0, tricksWon: 0),
      ];
      final List<Player> expectedPlayersValue = [
        Player(mockPlayers[0].id, name: mockPlayers[0].name, score: -10),
        Player(mockPlayers[1].id, name: mockPlayers[1].name, score: 30),
        Player(mockPlayers[2].id, name: mockPlayers[2].name, score: 40),
      ];

      // WHEN
      gameBloc.add(GameRoundEnded(endRoundPlayersScores));
      await tester.pump();
      gameBloc.add(GameRoundEnded(endRound2PlayersScores));
      await tester.pump();

      await tester.tap(scoreAppBar);
      await tester.pumpAndSettle(const Duration(microseconds: 200));
      final Finder scoreboard = find.byKey(const ValueKey('scoreboard'));
      final ScoreBoard scoreboardWidget =
          scoreboard.evaluate().single.widget as ScoreBoard;

      // THEN
      expect(scoreboard, findsOneWidget);
      expect(scoreboardWidget.players, equals(expectedPlayersValue));
      expect(scoreboardWidget.leadPlayers.length, 1);
    });
  });
}
