import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class ScoreBoard extends StatelessWidget {
  ScoreBoard({
    super.key,
    required this.players,
    required this.leadPlayers,
  }) : assert(
          players.isNotEmpty,
          leadPlayers.isNotEmpty,
        );

  final List<Player> players;
  final List<Player> leadPlayers;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        key: const ValueKey("scoreboard_expanded"),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 10,
            mainAxisSpacing: scoreboardRowSpacing),
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
