import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_scoreboard.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class GameAppBar extends StatefulWidget {
  GameAppBar({
    super.key,
    required this.leadPlayers,
    required this.players,
  }) : assert(
          leadPlayers.isNotEmpty,
          players.isNotEmpty,
        );

  final List<Player> leadPlayers;
  final List<Player> players;

  @override
  State<StatefulWidget> createState() => _GameAppBar();
}

class _GameAppBar extends State<GameAppBar> {
  double height = playerTitleHeight + scoreboardRowSpacing + 20;
  double maxHeight = 150;
  bool isExpanded = false;
  double containerHeight = playerTitleHeight + scoreboardRowSpacing + 20;

  @override
  void initState() {
    super.initState();
    int numberOfRow = (widget.players.length / 2).ceil();
    maxHeight = (numberOfRow * playerTitleHeight) +
        (numberOfRow * scoreboardRowSpacing) +
        20;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const ValueKey("score_app_bar"),
      onTap: () => {
        setState(() {
          isExpanded = !isExpanded;
        }),
        setState(() {
          containerHeight = isExpanded ? maxHeight : height;
        }),
      },
      child: AnimatedContainer(
        height: containerHeight,
        clipBehavior: Clip.none,
        duration: const Duration(milliseconds: 150),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 7),
            ),
          ],
          color: secondaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(componentsRadius),
            bottomRight: Radius.circular(componentsRadius),
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) {
                  if (isExpanded == false) {
                    final Player firstLeaderPlayer = widget.leadPlayers[0];

                    return Row(
                      key: const ValueKey("scoreboard_unexpanded"),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SKPlayerTitle(
                            playerName: firstLeaderPlayer.name, isLeader: true),
                        SKText(text: ': ${firstLeaderPlayer.score}'),
                      ],
                    );
                  } else {
                    return ScoreBoard(
                        players: widget.players,
                        leadPlayers: widget.leadPlayers);
                  }
                },
              ),
              const Icon(Icons.horizontal_rule_rounded, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
