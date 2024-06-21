import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/usecases/calcul_round_score.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_card.dart';

class GamePlayerCardList extends StatefulWidget {
  const GamePlayerCardList({
    super.key,
    required this.players,
    required this.leadPlayers,
    required this.round,
  });

  final List<Player> leadPlayers;
  final List<Player> players;
  final Round round;

  @override
  State<StatefulWidget> createState() => _GamePlayerCardList();
}

class _GamePlayerCardList extends State<GamePlayerCardList> {
  void onBonusPressed(UniqueKey playerId, BonusKey bonusKey, int amount) {
    context.read<RoundScoreCubit>().onBonusPressed(playerId, bonusKey, amount);
    setState(() {});
  }

  void onBidsChanged(UniqueKey playerId, String value) {
    context.read<RoundScoreCubit>().onBidsChanged(playerId, value);
    setState(() {});
  }

  void onWonTricksChanged(UniqueKey playerId, String value) {
    context.read<RoundScoreCubit>().onWonTricksChanged(playerId, value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BlocBuilder<RoundScoreCubit, List<PlayerRoundScore>>(
            builder: (context, state) {
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: widget.players.length,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final Player player = widget.players[index];
                  final PlayerRoundScore playerRoundScore =
                      state.singleWhere((elem) => elem.playerId == player.id);
                  final int roundScore =
                      CalculRoundScore.execute(widget.round, playerRoundScore);

                  return SKPlayerCard(
                    playerName: player.name,
                    isScoreLeader: widget.leadPlayers.contains(player),
                    maxValue: widget.round.getValue(),
                    playerRoundScore: playerRoundScore,
                    currentRoundScore: roundScore,
                    onPiratePressed: (amount) =>
                        onBonusPressed(player.id, BonusKey.pirate, amount),
                    onMermaidPressed: (amount) =>
                        onBonusPressed(player.id, BonusKey.mermaid, amount),
                    onSkullKingPressed: (amount) =>
                        onBonusPressed(player.id, BonusKey.skullKing, amount),
                    onTenPressed: (amount) =>
                        onBonusPressed(player.id, BonusKey.tenPoints, amount),
                    onAllyPressed: (amount) =>
                        onBonusPressed(player.id, BonusKey.alliance, amount),
                    onBetPressed: (amount) =>
                        onBonusPressed(player.id, BonusKey.rascalBet, amount),
                    onBidsChanged: (value) => onBidsChanged(player.id, value),
                    onWonTricksChanged: (value) =>
                        onWonTricksChanged(player.id, value),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
