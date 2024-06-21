import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/calcul_round_score.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_card.dart';

class GamePlayerCardList extends StatefulWidget {
  const GamePlayerCardList(
      {super.key,
      required this.players,
      required this.leadPlayers,
      required this.playersRoundScores,
      required this.round,
      required this.openDrawer});

  final List<Player> leadPlayers;
  final List<PlayerRoundScore> playersRoundScores;
  final List<Player> players;
  final Round round;
  final Function() openDrawer;

  @override
  State<GamePlayerCardList> createState() => _GamePlayerCardList();
}

class _GamePlayerCardList extends State<GamePlayerCardList> {
  late List<PlayerRoundScore> playersRoundScores;

  @override
  void initState() {
    super.initState();
    playersRoundScores = List.from(widget.playersRoundScores);
  }

  void onBonusPressed(UniqueKey playerId, BonusKey bonusKey, int amount) {
    setState(() {
      playersRoundScores
          .singleWhere((player) => player.playerId == playerId)
          .updatePlayerBonusAmount(playerId, bonusKey, amount);
    });
  }

  void onBidsChanged(UniqueKey playerId, String value) {
    setState(() {
      playersRoundScores
          .singleWhere((player) => player.playerId == playerId)
          .updatePlayerBidsValue(playerId, int.parse(value));
    });
  }

  void onWonTricksChanged(UniqueKey playerId, String value) {
    setState(() {
      playersRoundScores
          .singleWhere((player) => player.playerId == playerId)
          .updatePlayerWonTricksValue(playerId, int.parse(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemCount: widget.players.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final Player player = widget.players[index];
              final PlayerRoundScore playerRoundScore = playersRoundScores
                  .singleWhere((elem) => elem.playerId == player.id);
              final int roundScore =
                  CalculRoundScore.execute(widget.round, playerRoundScore);

              return SKPlayerCard(
                playerName: player.name,
                isScoreLeader: widget.leadPlayers.contains(player),
                maxValue: widget.round.getValue(),
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
          ),
        ),
      ],
    );
  }
}
