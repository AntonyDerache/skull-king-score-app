import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/domain/usecases/count_number_of_players_with_empty_name.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/game/game_event.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/alert_enums.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/utils/show_alert.dart';
import 'package:skull_king_score_app/src/presentation/utils/show_snackbar.dart';
import 'package:skull_king_score_app/src/presentation/views/home/home_background.dart';
import 'package:skull_king_score_app/src/presentation/views/home/players_list.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_drawer/sk_drawer.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void play(BuildContext context) async {
    List<PlayerState> players = List.from(context.read<PlayerCubit>().state);
    int numberOfPlayersName =
        CountNumberOfPlayersWithFilledName.execute(players);
    if (numberOfPlayersName < 2) {
      showSnackbar(context, "Please fill at least 2 players names");
      return;
    } else if (numberOfPlayersName < players.length) {
      // if (await showAlert(context, "Missing players names",
      //         "At least one player has no name. Do you wish to continue?") ==
      //     DialogAcceptEnum.approve) {
      //   List<Player> playersWithoutName =
      //       players.where((player) => player.name.isEmpty).toList();
      //   if (!context.mounted) return;
      //   context.read<PlayerCubit>().removePlayersById(
      //       playersWithoutName.map((player) => player.id).toList());
      //   players = List.from(context.read<PlayerCubit>().state);
      // } else {
      //   return;
      // }
    }
    if (!context.mounted) return;
    context.read<GameBloc>().add(
          GameStarted(
            List.from(players),
          ),
        );
    Navigator.pushNamed(context, gameUrl);
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      drawer: const SKDrawer(),
      body: Stack(
        children: [
          const HomeBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          alignment: Alignment.topCenter,
                          child: const Image(
                            height: 150,
                            width: 150,
                            opacity: AlwaysStoppedAnimation<double>(0.4),
                            image: AssetImage('assets/images/logo_saturé.png'),
                          )),
                      Container(
                        height: 175,
                        alignment: Alignment.center,
                        child: const FittedBox(
                          fit: BoxFit.contain,
                          child: SKText(
                              text: 'Skull King',
                              fontFamily: 'Allura',
                              fontSize: 82,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          iconSize: 28,
                          icon: const Icon(Icons.settings, color: Colors.white),
                          onPressed: () => openDrawer(),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<PlayerCubit, List<PlayerState>>(
                      builder: (context, state) {
                        return PlayersList(players: List.from(state));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: SKButton(
                        key: const ValueKey('test'),
                        label: AppLocalizations.of(context)!.start,
                        textWeight: FontWeight.bold,
                        onPressed: () => play(context),
                      ),
                    ),
                  ),
                  const SKText(text: '@copyright Antony', fontSize: 9),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
