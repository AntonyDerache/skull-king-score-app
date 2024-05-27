import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class SKPlayerTitle extends StatelessWidget {
  const SKPlayerTitle({
    super.key,
    required this.playerName,
    this.isLeader = false,
    this.fontSize = defaultFontSize,
    this.height = playerTitleHeight,
  });

  final String playerName;
  final bool isLeader;
  final double fontSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (isLeader)
            Image(
                height: height,
                width: height,
                image: const AssetImage('assets/images/logo.png')),
          SKText(text: playerName, fontSize: fontSize)
        ]);
  }
}
