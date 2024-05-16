import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_icon_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard(
      {super.key, this.isScoreLeader = false, this.playerName = ''});

  final bool isScoreLeader;
  final String playerName;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: lightColor),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10, left: 20.0, right: 20.0, bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SkPlayerTitle(playerName: playerName, isLeader: isScoreLeader)
                  ],
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SkText(text: 'Bids:'),
                        SizedBox(width: 10),
                        SkText(text: '0'),
                      ],
                    ),
                    Row(
                      children: [
                        SkText(text: 'Tricks won:'),
                        SizedBox(width: 10),
                        SkText(text: '0'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const SkText(text: 'Bonus Points'),
                const SizedBox(height: 5),
                const Row(
                  children: [
                    SkIconButton(
                        icon: Image(
                            image: AssetImage('assets/icons/pirate.png'))),
                    SizedBox(width: 10),
                    SkIconButton(
                        icon: Image(
                            image: AssetImage('assets/icons/mermaid.png'))),
                    SizedBox(width: 10),
                    SkIconButton(
                        icon: Image(
                            image: AssetImage('assets/icons/skull_king.png'))),
                    SizedBox(width: 10),
                    SkIconButton(
                        icon: SkText(
                            text: '+10', color: Colors.black, fontSize: 11)),
                    SizedBox(width: 10),
                    SkIconButton(
                        icon:
                            Image(image: AssetImage('assets/icons/coins.png'))),
                    SizedBox(width: 10),
                    SkIconButton(
                        icon:
                            Image(image: AssetImage('assets/icons/pari.png'))),
                  ],
                ),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    SkText(text: 'Round score: '),
                    SkText(text: '+10', color: Colors.green)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
