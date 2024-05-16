import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/bloc/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/views/game/scoreboard.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class GameAppBar extends StatefulWidget {
  const GameAppBar({
    super.key,
    required this.leadPlayers,
    required this.numberOfPlayer
  });

  final List<PlayerState> leadPlayers;
  final int numberOfPlayer;

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
    int numberOfRow = (widget.numberOfPlayer / 2).ceil();
    maxHeight = (numberOfRow * playerTitleHeight) + (numberOfRow * scoreboardRowSpacing) + 20;
  }

  @override
  Widget build(BuildContext context) {
    final PlayerState firstLeaderPlayer = widget.leadPlayers[0];

    return InkWell(
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
                  offset: const Offset(0, 7)),
            ],
            color: secondaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(componentsRadius),
                bottomRight: Radius.circular(componentsRadius))),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<PlayerCubit, List<PlayerState>>(
                builder: (context, state) {
                  if (isExpanded == false) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SkPlayerTitle(playerName: firstLeaderPlayer.name, isLeader: true),
                        SkText(text: ': ${firstLeaderPlayer.score}'),
                      ],
                    );
                  } else {
                    return ScoreBoard(
                        players: state, leadPlayers: widget.leadPlayers);
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
