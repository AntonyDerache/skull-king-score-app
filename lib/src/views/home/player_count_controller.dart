import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/player/player_cubit.dart';

class PlayerCountController extends StatelessWidget {
  const PlayerCountController({
    super.key,
    this.numberOfPlayers = 0
  });

  final int numberOfPlayers;

  addPlayer(BuildContext context) {
    context.read<PlayerCubit>().addPlayer();
  }

  removePlayer(BuildContext context) {
    context.read<PlayerCubit>().removePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: const Icon(Icons.remove),
            iconSize: 32,
            color: Colors.white,
            disabledColor: Colors.grey,
            onPressed: numberOfPlayers <= 2 ? null : () => removePlayer(context)),
        Text('$numberOfPlayers / 8 players',
            style: const TextStyle(color: Colors.white)),
        IconButton(
          icon: const Icon(Icons.add),
          iconSize: 32,
          color: Colors.white,
          disabledColor: Colors.grey,
          onPressed: numberOfPlayers >= 8 ? null : () => addPlayer(context)
        ),
      ],
    );
  }
}
