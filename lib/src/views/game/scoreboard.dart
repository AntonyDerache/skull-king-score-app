import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/components/sk_text.dart';
import 'package:skull_king_score_app/src/cubits/player/player_state.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key, required this.players});

  final List<PlayerState> players;

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
              SkText(text: players[index].name),
              const SkText(text: ': '),
              SkText(text: players[index].score.toString()),
            ],
          );
        });
  }
}
