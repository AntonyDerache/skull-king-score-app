import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerCountController extends StatelessWidget {
  const PlayerCountController({
    super.key,
    this.numberOfPlayers = 0,
    required this.add,
    required this.remove,
  });

  final int numberOfPlayers;
  final Function() add;
  final Function() remove;

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
          onPressed: numberOfPlayers <= 2 ? null : remove,
        ),
        SKText(
          text: '$numberOfPlayers / 8 ${AppLocalizations.of(context)!.players}',
          color: Colors.white,
        ),
        IconButton(
          key: const ValueKey('btn_add_player'),
          icon: const Icon(Icons.add),
          iconSize: 32,
          color: Colors.white,
          disabledColor: Colors.grey,
          onPressed: numberOfPlayers >= 8 ? null : add,
        ),
      ],
    );
  }
}
