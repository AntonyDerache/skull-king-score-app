import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_lead_players.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_total_tricks_won.dart';
import 'package:skull_king_score_app/src/domain/usecases/is_end_round_data_correct.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/utils/dialog_accept_term.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_app_bar.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_background.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_players_card_list.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_alert_dialog.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_drawer/sk_drawer.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_icon_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<StatefulWidget> createState() => _Game();
}

class _Game extends State<StatefulWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future<DialogAcceptTerm?> showKrakenDialog() async {
    return await showDialog(
      context: context,
      builder: (_) => SKAlertDialog(
        title: AppLocalizations.of(context)!.krakenDialogTitle,
        content: SKText(
          text: AppLocalizations.of(context)!.krakenDialogContent,
        ),
      ),
      barrierDismissible: true,
    );
  }

  Future<bool> isKakrenNotBeenPlayed(
      BuildContext context, Round round, int tricksWonInRound) async {
    if (round.getValue() - tricksWonInRound == 1 &&
        await showKrakenDialog() == DialogAcceptTerm.approve) {
      return false;
    }
    if (!context.mounted) return true;
    SnackBar snackbar = SnackBar(
      showCloseIcon: true,
      content: Text(AppLocalizations.of(context)!.invalidInput),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    return true;
  }

  void endRound(BuildContext context, Round round,
      List<RoundScorePlayer> playersRoundScores) async {
    int tricksWonInRound = GetTotalTricksWon.execute(
        context.read<RoundBloc>().state.roundHistory[round.getValue() - 1]);
    if (IsEndRoundDataIncorrect.execute(tricksWonInRound, round)) {
      if (await isKakrenNotBeenPlayed(context, round, tricksWonInRound)) {
        return;
      }
    }

    if (!context.mounted) return;
    context.read<RoundBloc>().add(EndRound(playersRoundScores));
    round.getValue() < 10
        ? Navigator.pushNamed(context, gameUrl)
        : Navigator.pushNamed(context, resultUrl);
  }

  void previousRound() {
    if (context.read<RoundBloc>().state.round.getValue() > 1) {
      context.read<RoundBloc>().add(PreviousRound());
    }
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      drawer: const SKDrawer(),
      body: PopScope(
        onPopInvoked: (bool invoked) {
          if (invoked) {
            previousRound();
          }
        },
        child: Stack(children: [
          const GameBackground(),
          SafeArea(
            child: BlocBuilder<RoundBloc, RoundState>(
              builder: (context, state) {
                List<Player> leadPlayers =
                    GetLeadPlayers.execute(List.from(state.playersInGame));
                List<RoundScorePlayer> playersScores = state
                    .roundHistory[state.round.getValue() - 1]
                    .map((item) => RoundScorePlayer.clone(item))
                    .toList();

                return Column(
                  children: [
                    GameAppBar(
                        leadPlayers: leadPlayers, players: state.playersInGame),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: GamePlayerCardList(
                          players: state.playersInGame,
                          playersRoundScores: playersScores,
                          leadPlayers: leadPlayers,
                          round: state.round,
                          openDrawer: openDrawer,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SKIconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context)),
                          const SizedBox(width: 5),
                          Flexible(
                            child: SKButton(
                              label:
                                  '${AppLocalizations.of(context)!.endRound} ${state.round.getValue()}',
                              onPressed: () =>
                                  endRound(context, state.round, playersScores),
                            ),
                          ),
                          const SizedBox(width: 5),
                          SKIconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () => openDrawer(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
