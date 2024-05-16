import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/bloc/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_app_bar.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_background.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_card.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  back(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final leadPlayers = context.read<PlayerCubit>().getLeadPlayers();
    final numberOfPlayer = context.read<PlayerCubit>().getNumberOfPlayer();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        const GameBackground(),
        SafeArea(
          child: Column(
            children: [
              GameAppBar(
                  leadPlayers: leadPlayers, numberOfPlayer: numberOfPlayer),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      BlocBuilder<PlayerCubit, List<PlayerState>>(
                        builder: (context, state) {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: state.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final PlayerState player = state[index];

                                  return Column(
                                    children: [
                                      SKPlayerCard(
                                          playerName: player.name,
                                          isScoreLeader:
                                              leadPlayers.contains(player),
                                          round: 1),
                                      if (index < state.length - 1)
                                        const SizedBox(height: 15),
                                    ],
                                  );
                                }),
                          );
                        },
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: SKButton(
                            label: 'End Round 2',
                          ),
                        ),
                      ),
                    ],
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
