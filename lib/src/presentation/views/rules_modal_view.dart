import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/views/rules_modal_bonus_info.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class RulesModalView extends StatelessWidget {
  const RulesModalView({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .8,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(alignment: Alignment.center, children: [
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                    color: lightColor,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context)),
              ),
              const SKText(text: 'Rules', fontSize: 24),
            ]),
            const SizedBox(height: 20),
            const Expanded(
              child: Column(children: [
                RulesModalBonusInfo(
                    title: 'Mermaid',
                    description:
                        'Add a Mermaid if player has beaten one using a Pirate',
                    iconPath: 'assets/icons/mermaid.png'),
                SizedBox(height: 15),
                RulesModalBonusInfo(
                    title: 'Pirate',
                    description:
                        'Add a Pirate if player has beaten one using a Skull King',
                    iconPath: 'assets/icons/pirate.png'),
                SizedBox(height: 15),
                RulesModalBonusInfo(
                    title: 'Skull King',
                    description:
                        'Add a Skull King if player has beaten one using a Mermaid',
                    iconPath: 'assets/icons/skull_king.png'),
                SizedBox(height: 15),
                RulesModalBonusInfo(
                    title: '+10',
                    description:
                        "Add Ten points for any 14 cards the current bids' winner gained",
                    iconPath: 'assets/icons/number_10.png'),
                SizedBox(height: 15),
                RulesModalBonusInfo(
                    title: 'Alliance',
                    description:
                        'Add an Alliance for players who both won their respective bids',
                    iconPath: 'assets/icons/coins.png'),
                SizedBox(height: 15),
                RulesModalBonusInfo(
                    title: 'Rascal Bet',
                    description:
                        'Add Rascal Bet when a player win a bid using the Pirate Rascal and bet on his win',
                    iconPath: 'assets/icons/pari.png'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
