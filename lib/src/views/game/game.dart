import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/components/sk_button.dart';
import 'package:skull_king_score_app/src/components/sk_player_card.dart';
import 'package:skull_king_score_app/src/cubits/player/player_cubit.dart';
import 'package:skull_king_score_app/src/cubits/player/player_state.dart';
import 'package:skull_king_score_app/src/layout/game_app_bar.dart';
import 'package:skull_king_score_app/src/layout/game_background.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  back(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        const GameBackground(),
        SafeArea(
          child: Column(
            children: [
              const GameAppBar(),
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
                                  return Column(
                                    children: [
                                      const PlayerCard(
                                          playerName: 'Player 1',
                                          isScoreLeader: true),
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
