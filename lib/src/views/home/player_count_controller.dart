import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/components/sk_text.dart';

class PlayerCountController extends StatelessWidget {
  const PlayerCountController({
    super.key,
    this.numberOfPlayers = 0,
    required this.add,
    required this.remove
  });

  final int numberOfPlayers;
  final Function(BuildContext) add;
  final Function(BuildContext) remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: const Icon(Icons.remove),
            iconSize: 32,
            color: Colors.white,
            disabledColor: Colors.grey,
            onPressed:
                numberOfPlayers <= 2 ? null : () => remove(context)),
        SkText(text: '$numberOfPlayers / 8 players', color: Colors.white),
        IconButton(
            icon: const Icon(Icons.add),
            iconSize: 32,
            color: Colors.white,
            disabledColor: Colors.grey,
            onPressed: numberOfPlayers >= 8 ? null : () => add(context)),
      ],
    );
  }
}
