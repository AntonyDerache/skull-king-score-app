import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_bloc.dart';
import 'package:skull_king_score_app/src/presentation/bloc/round/round_event.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/player/player_state.dart';
import 'package:skull_king_score_app/src/presentation/cubit/round/round_score_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/views/home/home_background.dart';
import 'package:skull_king_score_app/src/presentation/views/home/players_list.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void play(BuildContext context) async {
    context.read<RoundBloc>().add(StartRound());
    context.read<RoundScoreCubit>().reset();
    Navigator.pushNamed(context, gameUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const HomeBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          alignment: Alignment.topCenter,
                          child: const Image(
                            height: 175,
                            width: 175,
                            opacity: AlwaysStoppedAnimation<double>(0.4),
                            image: AssetImage('assets/images/logo_saturé.png'),
                          )),
                      Container(
                        height: 200,
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
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<PlayerCubit, List<PlayerState>>(
                      builder: (context, state) {
                        return PlayersList(players: state);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: SKButton(
                        label: 'Start',
                        onPressed: () => play(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
