import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/components/sk_button.dart';
import 'package:skull_king_score_app/src/components/sk_player_card.dart';
import 'package:skull_king_score_app/src/layout/GameBackground.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  back(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const GameBackground(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SKButton(
                  label: 'Back',
                  onPressed: () => back(context),
                ),
                const PlayerCard(playerName: 'Player 1', isScoreLeader: true),
                const SizedBox(height: 15),
                const PlayerCard(playerName: 'Player 2'),
                const SizedBox(height: 15),
                const PlayerCard(playerName: 'Player 3'),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
