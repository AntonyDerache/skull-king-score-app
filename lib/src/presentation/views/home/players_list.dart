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

  onPlayerNameChange(BuildContext context, UniqueKey playerId, String name) {
    context.read<PlayerCubit>().updatePlayerName(playerId, name);
  }

  addPlayer(BuildContext context) {
    PlayerCubit cubit = context.read<PlayerCubit>();
    cubit.addPlayer();
    listKey.currentState!.insertItem(cubit.state.length - 1,
        duration: const Duration(milliseconds: 200));
  }

  removePlayer(BuildContext context) {
    context.read<PlayerCubit>().removePlayer();
    final cubit = context.read<PlayerCubit>();
    listKey.currentState!.removeItem(
        cubit.state.length,
        (context, animation) =>
            buildListItem(animation, cubit.state.length - 1, context),
        duration: const Duration(milliseconds: 150));
  }

  Widget buildListItem(
          Animation<double> animation, int index, BuildContext context) =>
      PlayerListItem(
        text: widget.players[index].name,
        animation: animation,
        index: index,
        onChange: (value) =>
            onPlayerNameChange(context, widget.players[index].id, value),
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
              return buildListItem(animation, index, context);
            },
          ),
        )
      ],
    );
  }
}
