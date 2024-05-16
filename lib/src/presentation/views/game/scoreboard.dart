import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/bloc/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard(
      {super.key, required this.players, required this.leadPlayers});

  final List<PlayerState> players;
  final List<PlayerState> leadPlayers;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 10, mainAxisSpacing: 10),
        itemCount: players.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadPlayers.contains(players[index]))
                const Row(children: [
                  Image(
                      width: 32,
                      height: 32,
                      image: AssetImage('assets/images/logo.png')),
                  SizedBox(width: 10)
                ]),
              SkText(text: players[index].name),
              const SkText(text: ': '),
              SkText(text: players[index].score.toString()),
            ],
          );
        });
  }
}
