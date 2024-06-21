import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_bonus_icon_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class HelpModalBonusInfo extends StatelessWidget {
  const HelpModalBonusInfo({
    super.key,
    required this.title,
    required this.description,
    required this.iconPath,
  });

  final String title;
  final String description;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SKText(text: title, fontWeight: FontWeight.bold),
        const SizedBox(height: 5),
        Row(children: [
          SKBonusIconButton(
            icon: Image(
              image: AssetImage(iconPath),
            ),
            maxAmount: 0,
            value: 0,
            onPressed: null,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: SKText(text: description),
          ),
        ]),
      ],
    );
  }
}
