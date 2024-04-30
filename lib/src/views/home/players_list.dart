import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/components/sk_text_field.dart';
import 'package:skull_king_score_app/src/cubits/player/player_cubit.dart';
import 'package:skull_king_score_app/src/cubits/player/player_state.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({super.key, required this.players});

  final List<PlayerState> players;

  onPlayerNameChange(BuildContext context, UniqueKey playerId, String name) {
    context.read<PlayerCubit>().updatePlayerName(playerId, name);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: players.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SKTextInput(
                text: players[index].name,
                placeholder: "Enter player's name",
                onChange: (value) =>
                    onPlayerNameChange(context, players[index].id, value),
              ),
              const SizedBox(height: 10)
            ],
          );
        },
      ),
    );
  }
}
