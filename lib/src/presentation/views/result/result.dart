import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_lead_players.dart';
import 'package:skull_king_score_app/src/domain/usecases/get_result_list.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_event.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/views/game/game_background.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_icon_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void previousRound(BuildContext context) {
    context.read<GameBloc>().add(GamePreviousRound());
  }

  void goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, baseUrl, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PopScope(
        onPopInvoked: (bool invoked) {
          if (invoked) {
            previousRound(context);
          }
        },
        child: Stack(children: [
          const GameBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SKText(
                        text: AppLocalizations.of(context)!.result,
                        fontFamily: 'Allura',
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: BlocBuilder<GameBloc, GameState>(
                        builder: (context, state) {
                          final resultPlayers =
                              GetResultList.execute(state.playersInGame);
                          final leadPlayers =
                              GetLeadPlayers.execute(state.playersInGame);

                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            physics: const ClampingScrollPhysics(),
                            itemCount: resultPlayers.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String playerName = resultPlayers[index].name;
                              String score =
                                  resultPlayers[index].score.toString();
                              bool isLeader =
                                  leadPlayers.contains(resultPlayers[index]);

                              return Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 5,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  SKPlayerTitle(
                                    playerName: playerName,
                                    isLeader: isLeader,
                                    height: isLeader ? 42 : playerTitleHeight,
                                    fontSize: isLeader ? 28 : 20,
                                  ),
                                  SKText(
                                    text: score,
                                    fontSize: isLeader ? 28 : 20,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        children: [
                          SKIconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => goBack(context),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: SKButton(
                              label: AppLocalizations.of(context)!.home,
                              onPressed: () => goHome(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
