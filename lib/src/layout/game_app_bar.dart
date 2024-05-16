import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/components/sk_text.dart';
import 'package:skull_king_score_app/src/constants/color.dart';
import 'package:skull_king_score_app/src/constants/constants.dart';
import 'package:skull_king_score_app/src/cubits/player/player_cubit.dart';
import 'package:skull_king_score_app/src/cubits/player/player_state.dart';
import 'package:skull_king_score_app/src/views/game/Scoreboard.dart';

class GameAppBar extends StatefulWidget {
  const GameAppBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameAppBar();
}

class _GameAppBar extends State<GameAppBar> {
  bool isExpanded = false;
  double height = 75;
  double maxHeight = 150;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        setState(() {
          isExpanded = !isExpanded;
        }),
        setState(() {
          height = isExpanded ? maxHeight : 75;
        }),
      },
      child: AnimatedContainer(
        height: height,
        clipBehavior: Clip.none,
        duration: const Duration(milliseconds: 250),
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
                  final leadPlayers =
                      context.read<PlayerCubit>().getLeadPlayers();
                  if (isExpanded == false) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                            width: 32,
                            height: 32,
                            image: AssetImage('assets/images/logo.png')),
                        const SizedBox(width: 10),
                        SkText(
                            text: '${leadPlayers[0].name}: ${leadPlayers[0].score}'),
                      ],
                    );
                  } else {
                    return ScoreBoard(players: state, leadPlayers: leadPlayers);
                  }
                },
              ),
              const Icon(Icons.horizontal_rule_rounded,
                  color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
