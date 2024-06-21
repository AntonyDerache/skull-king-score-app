import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/calcul_round_score.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_card.dart';

class GamePlayerCardList extends StatelessWidget {
  const GamePlayerCardList({
    super.key,
    required this.players,
    required this.leadPlayers,
    required this.round,
  });

  final List<Player> leadPlayers;
  final List<Player> players;
  final Round round;

  void onBonusPressed(
      BuildContext context, UniqueKey playerId, BonusKey bonusKey, int amount) {
    context.read<RoundScoreCubit>().onBonusPressed(playerId, bonusKey, amount);
  }

  void onBidsChanged(BuildContext context, UniqueKey playerId, String value) {
    context.read<RoundScoreCubit>().onBidsChanged(playerId, value);
  }

  void onWonTricksChanged(
      BuildContext context, UniqueKey playerId, String value) {
    context.read<RoundScoreCubit>().onWonTricksChanged(playerId, value);
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
                itemCount: players.length,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final Player player = players[index];
                  final PlayerRoundScore playerRoundScore =
                      state.singleWhere((elem) => elem.playerId == player.id);
                  final int roundScore =
                      CalculRoundScore.execute(round, playerRoundScore);

                  return SKPlayerCard(
                    playerName: player.name,
                    isScoreLeader: leadPlayers.contains(player),
                    maxValue: round.getValue(),
                    playerRoundScore: playerRoundScore,
                    currentRoundScore: roundScore,
                    onPiratePressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.pirate, amount),
                    onMermaidPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.mermaid, amount),
                    onSkullKingPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.skullKing, amount),
                    onTenPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.tenPoints, amount),
                    onAllyPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.alliance, amount),
                    onBetPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.rascalBet, amount),
                    onBidsChanged: (value) =>
                        onBidsChanged(context, player.id, value),
                    onWonTricksChanged: (value) =>
                        onWonTricksChanged(context, player.id, value),
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
