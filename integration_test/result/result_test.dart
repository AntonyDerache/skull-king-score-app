import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/views/result/result.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

import '../../test/mocks/bloc/game_bloc_mock.dart';
import '../createWidgetUnderTest.dart';

void main() {
  final List<Player> mockPlayers = [
    Player(UniqueKey(), name: "a", score: 490),
    Player(UniqueKey(), name: "b", score: 170),
  ];
  final GameState mockGameState = GameState(
    const Round(10),
    playersInGame: mockPlayers,
    roundHistory: const [[]],
    historyStatus: GameHistorySatus.normal,
  );
  late GameBloc gameBloc;

  setUp(() {
    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(mockGameState);
  });

  testWidgets("result of game", (WidgetTester tester) async {
    // GIVEN
    await tester.pumpWidget(
      BlocProvider.value(
        value: gameBloc,
        child: createWidgetUnderTest(const Result(), initialRoute: resultUrl),
      ),
    );

    // WHEN
    await tester.pump();
    final SKPlayerTitle firstPlayerName = find
        .byKey(const ValueKey("player_name_0"))
        .evaluate()
        .single
        .widget as SKPlayerTitle;
    final SKPlayerTitle secondPlayerName = find
        .byKey(const ValueKey("player_name_1"))
        .evaluate()
        .single
        .widget as SKPlayerTitle;
    final SKText firstPlayerScore = find
        .byKey(const ValueKey("player_score_0"))
        .evaluate()
        .single
        .widget as SKText;
    final SKText secondPlayerScore = find
        .byKey(const ValueKey("player_score_1"))
        .evaluate()
        .single
        .widget as SKText;

    // THEN
    expect(firstPlayerName.playerName, equals(mockPlayers[0].name));
    expect(firstPlayerScore.text, equals(mockPlayers[0].score.toString()));
    expect(secondPlayerName.playerName, equals(mockPlayers[1].name));
    expect(secondPlayerScore.text, equals(mockPlayers[1].score.toString()));
  });
}
