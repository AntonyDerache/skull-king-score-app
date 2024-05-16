import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/bloc/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
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
            crossAxisCount: 2, childAspectRatio: 10, mainAxisSpacing: scoreboardRowSpacing),
        itemCount: players.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SKPlayerTitle(
                playerName: players[index].name,
                isLeader: leadPlayers.contains(players[index]),
              ),
              SKText(text: ': ${players[index].score.toString()}'),
            ],
          );
        });
  }
}
