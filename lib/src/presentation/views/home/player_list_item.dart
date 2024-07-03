import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({
    super.key,
    required this.onChange,
    required this.player,
  });

  final Player player;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SKTextInput(
          key: ValueKey("${player.id}_name_input"),
          testKey: "${player.id}_name_input",
          text: player.name,
          placeholder: AppLocalizations.of(context)!.playersDefaultPlaceholder,
          onChange: (value) => onChange(value),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
