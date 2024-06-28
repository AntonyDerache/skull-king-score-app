import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({
    super.key,
    required this.onChange,
    required this.text,
  });

  final String text;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SKTextInput(
          text: text,
          placeholder: AppLocalizations.of(context)!.playersDefaultPlaceholder,
          onChange: (value) => onChange(value),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
