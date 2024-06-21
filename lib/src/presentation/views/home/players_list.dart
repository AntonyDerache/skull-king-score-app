import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/views/home/player_count_controller.dart';
import 'package:skull_king_score_app/src/presentation/views/home/player_list_item.dart';

class PlayersList extends StatefulWidget {
  final List<PlayerState> players;

  const PlayersList({
    super.key,
    required this.players,
  });

  @override
  State<PlayersList> createState() => _PlayersList();
}

class _PlayersList extends State<PlayersList> {
  final listKey = GlobalKey<AnimatedListState>();

  void onPlayerNameChange(UniqueKey playerId, String name) {
    context.read<PlayerCubit>().updatePlayerName(playerId, name);
  }

  void addPlayer() {
    context.read<PlayerCubit>().addPlayer();
    listKey.currentState!.insertItem(
      context.read<PlayerCubit>().state.length - 1,
      duration: const Duration(milliseconds: 200),
    );
  }

  void removePlayer() {
    context.read<PlayerCubit>().removePlayer();
    listKey.currentState!.removeItem(
      context.read<PlayerCubit>().state.length,
      (context, animation) => buildListItem(
        animation,
        context.read<PlayerCubit>().state.length - 1,
      ),
      duration: const Duration(milliseconds: 150),
    );
  }

  Widget buildListItem(Animation<double> animation, int index) =>
      PlayerListItem(
        text: widget.players[index].name,
        animation: animation,
        index: index,
        onChange: (value) =>
            onPlayerNameChange(widget.players[index].id, value),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlayerCountController(
            numberOfPlayers: widget.players.length,
            add: addPlayer,
            remove: removePlayer),
        Flexible(
          child: AnimatedList(
            physics: const ClampingScrollPhysics(),
            key: listKey,
            initialItemCount: widget.players.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return buildListItem(animation, index);
            },
          ),
        )
      ],
    );
  }
}
