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
  void nextRound(BuildContext context, int round) {
    if (round < 10) {
      Navigator.pushNamed(context, gameUrl).then((value) => setState(() {}));
    } else {
      Navigator.pushNamed(context, resultUrl).then((value) => setState(() {}));
    }
  }

  void updatePlayerScore(List<PlayerState> players, int round) {
    for (PlayerState player in players) {
      int playerScore = context
          .read<RoundScoreCubit>()
          .getCurrentPlayerRoundScore(player.id, round);
      context.read<PlayerCubit>().updatePlayerScore(player.id, playerScore);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int round = context.read<RoundBloc>().state.round;
    final List<PlayerState> players = context.read<PlayerCubit>().state;
    context.read<RoundScoreCubit>().initNewRound(players, round);
    updatePlayerScore(players, round);
    final List<PlayerState> leadPlayers =
        context.read<PlayerCubit>().getLeadPlayers();
    final int numberOfPlayer = players.length;


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
