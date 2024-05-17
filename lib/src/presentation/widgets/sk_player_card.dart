import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_bonus_icon_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_number_field.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class SKPlayerCard extends StatelessWidget {
  const SKPlayerCard({
    super.key,
    this.isScoreLeader = false,
    this.playerName = '',
    required this.round,
  });

  final bool isScoreLeader;
  final String playerName;
  final int round;

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
                    SKPlayerTitle(
                        playerName: playerName, isLeader: isScoreLeader)
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const SKText(text: 'Bids:'),
                          const SizedBox(width: 10),
                          SizedBox(
                              width: 20, child: SKNumberField(round: round)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const SKText(text: 'Tricks won:'),
                        const SizedBox(width: 10),
                        SizedBox(width: 20, child: SKNumberField(round: round)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const SKText(text: 'Bonus Points'),
                const SizedBox(height: 5),
                const Wrap(
                  spacing: 10,
                  children: [
                    SKBonusIconButton(
                        icon: Image(
                            image: AssetImage('assets/icons/pirate.png'))),
                    SKBonusIconButton(
                        icon: Image(
                            image: AssetImage('assets/icons/mermaid.png'))),
                    SKBonusIconButton(
                        icon: Image(
                            image: AssetImage('assets/icons/skull_king.png'))),
                    SKBonusIconButton(
                        icon: SKText(
                            text: '+10', color: Colors.black, fontSize: 11)),
                    SKBonusIconButton(
                        icon:
                            Image(image: AssetImage('assets/icons/coins.png'))),
                    SKBonusIconButton(
                        icon:
                            Image(image: AssetImage('assets/icons/pari.png'))),
                  ],
                ),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    SKText(text: 'Round score: '),
                    SKText(text: '+10', color: Colors.green)
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
