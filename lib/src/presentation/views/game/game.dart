import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_cubit.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_app_bar.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_background.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_players_card_list.dart';

class Game extends StatelessWidget {
  const Game({super.key, required this.round});

  final int round;

  @override
  Widget build(BuildContext context) {
    final players = context.read<PlayerCubit>().state;
    final leadPlayers = context.read<PlayerCubit>().getLeadPlayers();
    final numberOfPlayer = players.length;

    context.read<RoundCubit>().initNewRound(players, round);

    for (PlayerState player in players) {
      int playerScore = context
          .read<RoundCubit>()
          .getCurrentPlayerRoundScore(player.id, round);
      context.read<PlayerCubit>().updatePlayerScore(player.id, playerScore);
    }

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
