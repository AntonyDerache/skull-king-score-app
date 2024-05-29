import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_score_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_app_bar.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_background.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_players_card_list.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<StatefulWidget> createState() => _Game();
}

class _Game extends State<StatefulWidget> {
  int round = 0;
  List<PlayerState> players = List.empty();
  List<PlayerState> leadPlayers = List.empty();
  int numberOfPlayer = 0;

  @override
  void initState() {
    super.initState();
    PlayerCubit playerCubit = context.read<PlayerCubit>();

    players = playerCubit.state;
    leadPlayers = playerCubit.getLeadPlayers();
    numberOfPlayer = players.length;
    round = context.read<RoundBloc>().state.round;
  }

  void updatePlayerScore(List<PlayerState> players, int round) {
    for (PlayerState player in players) {
      int playerScore = context
          .read<RoundScoreCubit>()
          .getCurrentPlayerRoundScore(player.id, round);
      context.read<PlayerCubit>().updatePlayerScore(player.id, playerScore);
    }
  }

  void nextRound(int round) {
    if (round < 10) {
      Navigator.pushNamed(context, gameUrl).then((value) => setState(() {}));
    } else {
      initRound(players, round + 1);
      Navigator.pushNamed(context, resultUrl).then((value) => setState(() {}));
    }
  }

  void initRound(List<PlayerState> players, int round) {
    context.read<RoundScoreCubit>().initNewRound(players, round);
    updatePlayerScore(players, round);
  }

  @override
  Widget build(BuildContext context) {
    initRound(players, round);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        const GameBackground(),
        SafeArea(
          child: Column(
            children: [
              GameAppBar(
                  leadPlayers: leadPlayers, numberOfPlayer: numberOfPlayer),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: GamePlayerCardList(
                    players: players,
                    leadPlayers: leadPlayers,
                    round: round,
                    nextRound: nextRound,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
