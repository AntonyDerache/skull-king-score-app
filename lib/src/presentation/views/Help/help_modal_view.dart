import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/views/Help/help_modal_bonus_info.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpModalView extends StatelessWidget {
  const HelpModalView({super.key});

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
              const SKText(text: 'Help', fontSize: 24),
            ]),
            const SizedBox(height: 20),
            Expanded(
              child: Column(children: [
                HelpModalBonusInfo(
                    title: AppLocalizations.of(context)!.mermaid,
                    description:
                        AppLocalizations.of(context)!.mermaid_description,
                    iconPath: 'assets/icons/mermaid.png'),
                const SizedBox(height: 15),
                HelpModalBonusInfo(
                    title: AppLocalizations.of(context)!.pirate,
                    description:
                        AppLocalizations.of(context)!.pirate_descrption,
                    iconPath: 'assets/icons/pirate.png'),
                const SizedBox(height: 15),
                HelpModalBonusInfo(
                    title: AppLocalizations.of(context)!.skull_king,
                    description:
                        AppLocalizations.of(context)!.skull_king_description,
                    iconPath: 'assets/icons/skull_king.png'),
                const SizedBox(height: 15),
                HelpModalBonusInfo(
                    title: AppLocalizations.of(context)!.ten_point,
                    description:
                        AppLocalizations.of(context)!.ten_point_description,
                    iconPath: 'assets/icons/number_10.png'),
                const SizedBox(height: 15),
                HelpModalBonusInfo(
                    title: AppLocalizations.of(context)!.alliance,
                    description:
                        AppLocalizations.of(context)!.alliance_description,
                    iconPath: 'assets/icons/coins.png'),
                const SizedBox(height: 15),
                HelpModalBonusInfo(
                    title: AppLocalizations.of(context)!.rascal_bet,
                    description:
                        AppLocalizations.of(context)!.rascal_bet_description,
                    iconPath: 'assets/icons/pari.png'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
