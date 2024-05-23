import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/calcul_round_score.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_cubit.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_icon_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_card.dart';

class GamePlayerCardList extends StatefulWidget {
  const GamePlayerCardList({
    super.key,
    required this.players,
    required this.leadPlayers,
    required this.round,
  });

  final List<PlayerState> leadPlayers;
  final List<PlayerState> players;
  final int round;

  final String baseUrl = '/game';

  back(BuildContext context) {
    Navigator.pop(context);
  }

  nextRound(BuildContext context, List<RoundScorePlayer> roundScorePlayers) {
    RoundCubit roundCubit = context.read<RoundCubit>();

    roundCubit.endRound(roundScorePlayers, round);

    Navigator.pushNamed(context, '$baseUrl/${round + 1}');
  }

  @override
  State<GamePlayerCardList> createState() => _GamePlayerCardList();
}

class _GamePlayerCardList extends State<GamePlayerCardList> {
  List<RoundScorePlayer> roundScorePlayers = List.empty();

  @override
  void initState() {
    super.initState();
    roundScorePlayers = List.generate(
        widget.players.length,
        (index) => RoundScorePlayer(
            widget.players[index].id, widget.players[index].score));
  }

  void onBonusPressed(
      BuildContext context, UniqueKey playerId, BonusKey bonusKey, int amount) {
    setState(() {
      roundScorePlayers
          .singleWhere((player) => player.playerId == playerId)
          .updatePlayerBonusAmount(playerId, bonusKey, amount);
    });
  }

  void onBidsChanged(BuildContext context, UniqueKey playerId, String value) {
    setState(() {
      roundScorePlayers
          .singleWhere((player) => player.playerId == playerId)
          .updatePlayerBidsValue(playerId, int.parse(value));
    });
  }

  void onWonTricksChanged(
      BuildContext context, UniqueKey playerId, String value) {
    setState(() {
      roundScorePlayers
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
                final PlayerState player = widget.players[index];
                RoundScorePlayer roundScorePlayer = roundScorePlayers
                    .singleWhere((elem) => elem.playerId == player.id);
                int roundScore = CalculRoundScore.call(
                    widget.round, roundScorePlayer);

                return SKPlayerCard(
                    playerName: player.name,
                    isScoreLeader: widget.leadPlayers.contains(player),
                    round: widget.round,
                    currentRoundScore: roundScore,
                    onPiratePressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.alliance, amount),
                    onMermaidPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.mermaid, amount),
                    onSkullKingPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.skullKing, amount),
                    onTenPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.tenPoints, amount),
                    onAllyPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.alliance, amount),
                    onBetPressed: (amount) => onBonusPressed(
                        context, player.id, BonusKey.bet, amount),
                    onBidsChanged: (value) =>
                        onBidsChanged(context, player.id, value),
                    onWonTricksChanged: (value) =>
                        onWonTricksChanged(context, player.id, value));
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SKIconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => widget.back(context)),
              const SizedBox(width: 5),
              Flexible(
                child: SKButton(
                  label: 'End Round ${widget.round}',
                  onPressed: () => widget.nextRound(context, roundScorePlayers),
                ),
              ),
              const SizedBox(width: 5),
              const SKIconButton(icon: Icon(Icons.menu)),
            ],
          ),
        ),
      ],
    );
  }
}
