import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class SkPlayerTitle extends StatelessWidget {
  const SkPlayerTitle({
    super.key,
    required this.playerName,
    this.isLeader = false,
  });

  final String playerName;
  final bool isLeader;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (isLeader)
            const Image(
                height: playerTitleHeight,
                width: playerTitleHeight,
                image: AssetImage('assets/images/logo.png')),
          SkText(text: playerName)
        ]);
  }
}
