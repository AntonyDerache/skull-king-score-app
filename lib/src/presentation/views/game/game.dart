import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_lead_players.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_total_tricks_won.dart';
import 'package:skull_king_score_app/src/domain/usecases/is_end_round_data_correct.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round_scores/round_scores_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/alert_enums.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/utils/list_utils.dart';
import 'package:skull_king_score_app/src/presentation/utils/show_alert.dart';
import 'package:skull_king_score_app/src/presentation/utils/show_snackbar.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_app_bar.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_background.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_players_card_list.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_drawer/sk_drawer.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_icon_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<StatefulWidget> createState() => _Game();
}

class _Game extends State<StatefulWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void endRound(BuildContext context, Round round) async {
    if (await checkIfHistoryBehindAndReturnIfUserReject(context, round)) {
      return;
    }

    if (!context.mounted) return;
    List<PlayerRoundScore> playersRoundScores =
        context.read<RoundScoreCubit>().state;
    int tricksWonInRound = GetTotalTricksWon.execute(playersRoundScores);
    if (await checkIfRoundDataIsIncorrectAndReturnIfUserReject(
      context,
      round,
      tricksWonInRound,
    )) {
      return;
    }

    if (!context.mounted) return;
    context.read<GameBloc>().add(GameRoundEnded(playersRoundScores));
    round.getValue() < 10
        ? Navigator.pushNamed(context, gameUrl).then((_) => setState(() => {}))
        : Navigator.pushNamed(context, resultUrl);
  }

  void previousRound() {
    if (context.read<GameBloc>().state.round.getValue() > 1) {
      context.read<GameBloc>().add(GamePreviousRound());
    }
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<bool> checkIfHistoryBehindAndReturnIfUserReject(
      BuildContext context, Round round) async {
    return isHistoryBehindAndDataNotSame(round) &&
        await showAlert(
              context,
              AppLocalizations.of(context)!.historyBehindDialogTitle,
              AppLocalizations.of(context)!.historyBehindDialogContent,
            ) ==
            DialogAcceptEnum.reject;
  }

  Future<bool> checkIfRoundDataIsIncorrectAndReturnIfUserReject(
      BuildContext context, Round round, int tricksWonInRound) async {
    IncorrectDataResult incorrectRsult =
        IsEndRoundDataIncorrect.execute(tricksWonInRound, round);
    if (incorrectRsult == IncorrectDataResult.inferior) {
      if (await isKakrenNotBeenPlayed(context, round, tricksWonInRound)) {
        if (!context.mounted) return true;
        showSnackbar(context, AppLocalizations.of(context)!.invalidInput);
        return true;
      }
    } else if (incorrectRsult == IncorrectDataResult.superior) {
      showSnackbar(context,
          '${AppLocalizations.of(context)!.tooMuchRoundRegistered} ($tricksWonInRound/${round.getValue()}).');
      return true;
    }
    return false;
  }

  Future<bool> isKakrenNotBeenPlayed(
      BuildContext context, Round round, int tricksWonInRound) async {
    return round.getValue() - tricksWonInRound == 1 &&
        await showAlert(
              context,
              AppLocalizations.of(context)!.krakenDialogTitle,
              AppLocalizations.of(context)!.krakenDialogContent,
            ) ==
            DialogAcceptEnum.reject;
  }

  bool isHistoryBehindAndDataNotSame(Round round) {
    return context.read<GameBloc>().state.historyStatus ==
            GameHistorySatus.behind &&
        ListUtils.areListsNotEquals<PlayerRoundScore>(
          context.read<RoundScoreCubit>().state,
          context.read<GameBloc>().state.roundHistory[round.getValue() - 1],
        );
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
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  List<Player> leadPlayers = GetLeadPlayers.execute(
                    List.from(state.playersInGame),
                  );

                  return Column(
                    children: [
                      GameAppBar(
                          leadPlayers: leadPlayers,
                          players: state.playersInGame),
                      Expanded(
                        child: GamePlayerCardList(
                          players: state.playersInGame,
                          leadPlayers: leadPlayers,
                          round: state.round,
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
                                onPressed: () => endRound(context, state.round),
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
          ),
        ]),
      ),
    );
  }
}
