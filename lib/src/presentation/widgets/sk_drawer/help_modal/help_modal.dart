import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_drawer/help_modal/help_modal_bonus_info.dart';
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
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
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
                      SKText(
                          text: AppLocalizations.of(context)!.help,
                          fontSize: 24),
                    ]),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: SKText(
                        text: AppLocalizations.of(context)!.bonusPoints,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Expanded(
                        child: Column(children: [
                          HelpModalBonusInfo(
                              title: AppLocalizations.of(context)!.mermaid,
                              description: AppLocalizations.of(context)!
                                  .mermaid_description,
                              iconPath: 'assets/icons/mermaid.png'),
                          const SizedBox(height: 15),
                          HelpModalBonusInfo(
                              title: AppLocalizations.of(context)!.pirate,
                              description: AppLocalizations.of(context)!
                                  .pirate_descrption,
                              iconPath: 'assets/icons/pirate.png'),
                          const SizedBox(height: 15),
                          HelpModalBonusInfo(
                              title: AppLocalizations.of(context)!.skull_king,
                              description: AppLocalizations.of(context)!
                                  .skull_king_description,
                              iconPath: 'assets/icons/skull_king.png'),
                          const SizedBox(height: 15),
                          HelpModalBonusInfo(
                              title: AppLocalizations.of(context)!.ten_point,
                              description: AppLocalizations.of(context)!
                                  .ten_point_description,
                              iconPath: 'assets/icons/number_10.png'),
                          const SizedBox(height: 15),
                          HelpModalBonusInfo(
                              title: AppLocalizations.of(context)!.alliance,
                              description: AppLocalizations.of(context)!
                                  .alliance_description,
                              iconPath: 'assets/icons/coins.png'),
                          const SizedBox(height: 15),
                          HelpModalBonusInfo(
                              title: AppLocalizations.of(context)!.rascal_bet,
                              description: AppLocalizations.of(context)!
                                  .rascal_bet_description,
                              iconPath: 'assets/icons/pari.png'),
                        ]),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 25),
                      child: SKText(
                        text: '${AppLocalizations.of(context)!.help} :',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: const SKText(
                              text: "Global",
                              fontWeight: FontWeight.bold,
                            )),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SKText(
                              text:
                                  "Dans le cas ou vous avez appuyez 1 fois de trop ou + sur un bonus, vous pouvez les réinitialiser à 0 en depassant leur valeur maximale (La veleure maximale du bonus +10 est de 10)"),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: const SKText(
                                text: "Alliance", fontWeight: FontWeight.bold)),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SKText(
                              text:
                                  "Si une alliance vient à se briser lors qu'un des 2 joueurs ne repecte plus son offre initiale, alors il vous faut remettre l'icone alliance à 0 (ou 1 dans le cas ou un joueur est en double alliance)"),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: const SKText(
                                text: "Pari rascal",
                                fontWeight: FontWeight.bold)),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SKText(
                              text:
                                  "Si un joueur perd son offre initiale, les points du pari Rascal se transformeront en malus automatiquement"),
                        )
                      ]),
                    )
                  ]);
            }),
      ),
    );
  }
}
