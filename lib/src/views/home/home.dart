import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/components/sk_button.dart';
import 'package:skull_king_score_app/src/layout/background.dart';
import 'package:skull_king_score_app/src/player/player_cubit.dart';
import 'package:skull_king_score_app/src/player/player_state.dart';
import 'package:skull_king_score_app/src/views/home/player_count_controller.dart';
import 'package:skull_king_score_app/src/views/home/players_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Padding(
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
                        opacity: AlwaysStoppedAnimation<double>(0.5),
                        image: AssetImage('assets/images/logo.png'),
                      )),
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text('Skull King',
                        style: TextStyle(
                            fontFamily: 'Allura',
                            fontSize: 82,
                            color: Colors.white)),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<PlayerCubit, List<PlayerState>>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlayerCountController(numberOfPlayers: state.length),
                        PlayersList(players: state),
                      ],
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SKButton(
                    label: 'Start',
                    onPressed: () => debugPrint('toto'),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
