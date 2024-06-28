import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/views/home/player_count_controller.dart';
import 'package:skull_king_score_app/src/presentation/views/home/player_list_item.dart';

class PlayersList extends StatefulWidget {
  const PlayersList({
    super.key,
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
  }

  void removePlayer() {
    context.read<PlayerCubit>().removePlayer();
  }

  void insertItemInList(int playersLength) {
    listKey.currentState!.insertItem(
      playersLength - 1,
      duration: const Duration(milliseconds: 200),
    );
  }

  void removeItemInList(int index, Player player) {
    listKey.currentState!.removeItem(
      index,
      (context, animation) => buildListItem(
        player,
        animation,
      ),
      duration: const Duration(milliseconds: 150),
    );
  }

  Widget buildListItem(
    Player player,
    Animation<double> animation,
  ) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: PlayerListItem(
        text: player.name,
        onChange: (value) => onPlayerNameChange(player.id, value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<PlayerCubit, PlayerState>(
        listenWhen: (previous, current) {
          return (current.lastPlayerAction == PlayerCubitActions.playerAdded) ||
              (current.lastPlayerAction == PlayerCubitActions.playersRemoved);
        },
        listener: (BuildContext context, Object? state) {
          if (state is PlayerState) {
            if (state.lastPlayerAction == PlayerCubitActions.playersRemoved) {
              for (PlayerRemoved playerRemoved in state.lastRemovedPlayers) {
                removeItemInList(playerRemoved.index, playerRemoved.player);
              }
            } else if (state.lastPlayerAction ==
                PlayerCubitActions.playerAdded) {
              insertItemInList(state.players.length);
            }
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlayerCountController(
                numberOfPlayers: state.players.length,
                add: addPlayer,
                remove: removePlayer,
              ),
              Flexible(
                child: AnimatedList(
                  physics: const ClampingScrollPhysics(),
                  key: listKey,
                  initialItemCount: state.players.length,
                  itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) {
                    return buildListItem(
                      state.players[index],
                      animation,
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
