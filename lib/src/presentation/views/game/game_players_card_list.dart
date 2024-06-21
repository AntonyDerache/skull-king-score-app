import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/calcul_round_score.dart';
import 'package:skull_king_score_app/src/domain/usecases/is_end_round_data_correct.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_event.dart';
import 'package:skull_king_score_app/src/presentation/utils/dialog_accept_term.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_alert_dialog.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_card.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class GamePlayerCardList extends StatefulWidget {
  const GamePlayerCardList(
      {super.key,
      required this.players,
      required this.leadPlayers,
      required this.playersRoundScores,
      required this.round,
      required this.openDrawer});

  final List<Player> leadPlayers;
  final List<RoundScorePlayer> playersRoundScores;
  final List<Player> players;
  final Round round;
  final Function() openDrawer;

  @override
  State<GamePlayerCardList> createState() => _GamePlayerCardList();
}

class _GamePlayerCardList extends State<GamePlayerCardList> {
  late List<RoundScorePlayer> roundScorePlayers;

  @override
  void initState() {
    super.initState();
    roundScorePlayers = List.from(widget.playersRoundScores);
  }

  void previousRound() {
    context.read<RoundBloc>().add(PreviousRound());
  }

  Future<bool> isKakrenBeenPlayed() async {
    DialogAcceptTerm? result = await showDialog(
        context: context,
        builder: (_) => const SKAlertDialog(
            title: 'Missing round',
            content: SKText(
                text:
                    "One round is missing does the kraken has been played during this round?")),
        barrierDismissible: true);
    if (result != DialogAcceptTerm.approve) {
      return true;
    }
    return false;
  }

  Future<bool> isDataMissing(int roundTricksWon) async {
    if (IsEndRoundDataCorrect.execute(roundTricksWon, widget.round)) {
      if (widget.round.getValue() - roundTricksWon == 1) {
        return await isKakrenBeenPlayed();
      }
      return true;
    }
    return false;
  }

  void endRound() {
    if (widget.round.getValue() < 10) {
      context
          .read<RoundBloc>()
          // .add(EndRound(List.from(roundScorePlayers)));
          .add(EndRound(widget.playersRoundScores));
    }
    // widget.nextRound(widget.round);
  }

  void nextRound() async {
    // int roundTricksWon = roundCubit.getRoundTicksWon(roundScorePlayers);

    // if (await isDataMissing(roundTricksWon)) {
    //   if (!context.mounted) return;
    //   SnackBar snackbar = SnackBar(
    //     showCloseIcon: true,
    //     content: Text(AppLocalizations.of(context)!.invalidInput),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
    //   return;
    // }
    // if (!context.mounted) return;
    endRound();
  }

  void onBonusPressed(UniqueKey playerId, BonusKey bonusKey, int amount) {
    setState(() {
      roundScorePlayers
          .singleWhere((player) => player.playerId == playerId)
          .updatePlayerBonusAmount(playerId, bonusKey, amount);
    });
  }

  void onBidsChanged(UniqueKey playerId, String value) {
    setState(() {
      roundScorePlayers
          .singleWhere((player) => player.playerId == playerId)
          .updatePlayerBidsValue(playerId, int.parse(value));
    });
  }

  void onWonTricksChanged(UniqueKey playerId, String value) {
    setState(() {
      roundScorePlayers
          .singleWhere((player) => player.playerId == playerId)
          .updatePlayerWonTricksValue(playerId, int.parse(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool invoked) {
        if (invoked) {
          previousRound();
        }
      },
      child: Column(
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
                final RoundScorePlayer roundScorePlayer = widget
                    .playersRoundScores
                    .singleWhere((elem) => elem.playerId == player.id);
                final int roundScore =
                    CalculRoundScore.execute(widget.round, roundScorePlayer);

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
      ),
    );
  }
}
