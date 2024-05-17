import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_app_bar.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_background.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_icon_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_card.dart';

class Game extends StatelessWidget {
  const Game({super.key, required this.round});

  final int round;
  final String baseUrl = '/game';


  back(BuildContext context) {
    Navigator.pop(context);
  }

  nextRound(BuildContext context) {
    Navigator.pushNamed(context, '$baseUrl/${round + 1}');
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
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<PlayerCubit, List<PlayerState>>(
                        builder: (context, state) {
                          return Expanded(
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 15),
                                itemCount: state.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final PlayerState player = state[index];

                                  return SKPlayerCard(
                                      playerName: player.name,
                                      isScoreLeader:
                                          leadPlayers.contains(player),
                                      round: 1);
                                }),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SKIconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => back(context)),
                            const SizedBox(width: 5),
                            Flexible(
                              child: SKButton(
                                label: 'End Round $round',
                                onPressed: () => nextRound(context),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const SKIconButton(icon: Icon(Icons.menu)),
                          ],
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
