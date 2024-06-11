import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_backdrop_filter.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_bonus_icon_button.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_number_field.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_player_title.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SKPlayerCard extends StatelessWidget {
  const SKPlayerCard({
    super.key,
    this.isScoreLeader = false,
    this.playerName = '',
    required this.currentRoundScore,
    required this.maxValue,
    this.onPiratePressed,
    this.onMermaidPressed,
    this.onSkullKingPressed,
    this.onTenPressed,
    this.onAllyPressed,
    this.onBetPressed,
    this.onBidsChanged,
    this.onWonTricksChanged,
  });

  final bool isScoreLeader;
  final String playerName;
  final int maxValue;
  final int currentRoundScore;

  final Function(int)? onPiratePressed;
  final Function(int)? onMermaidPressed;
  final Function(int)? onSkullKingPressed;
  final Function(int)? onTenPressed;
  final Function(int)? onAllyPressed;
  final Function(int)? onBetPressed;
  final Function(String)? onBidsChanged;
  final Function(String)? onWonTricksChanged;

  @override
  Widget build(BuildContext context) {
    return SKBackdropFilter(
      hasClipRect: true,
      sigmaX: 6,
      sigmaY: 6,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: lightColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10, left: 20.0, right: 20.0, bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SKPlayerTitle(playerName: playerName, isLeader: isScoreLeader)
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SKText(text: AppLocalizations.of(context)!.bids),
                      const SizedBox(width: 10),
                      SKNumberField(
                        maxValue: maxValue,
                        onChange: (String value) => onBidsChanged?.call(value),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SKText(text: AppLocalizations.of(context)!.tricks),
                      const SizedBox(width: 10),
                      SKNumberField(
                        maxValue: maxValue,
                        onChange: (String value) =>
                            onWonTricksChanged?.call(value),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SKText(text: AppLocalizations.of(context)!.bonusPoints),
              const SizedBox(height: 5),
              Wrap(
                spacing: 10,
                children: [
                  SKBonusIconButton(
                      icon: const Image(
                          image: AssetImage('assets/icons/pirate.png')),
                      maxAmount: 5,
                      onPressed: (amount) => onPiratePressed?.call(amount)),
                  SKBonusIconButton(
                      icon: const Image(
                          image: AssetImage('assets/icons/mermaid.png')),
                      maxAmount: 2,
                      onPressed: (amount) => onMermaidPressed?.call(amount)),
                  SKBonusIconButton(
                      icon: const Image(
                          image: AssetImage('assets/icons/skull_king.png')),
                      maxAmount: 1,
                      onPressed: (amount) => onSkullKingPressed?.call(amount)),
                  SKBonusIconButton(
                      icon: const SKText(
                          text: '+10', color: Colors.black, fontSize: 11),
                      maxAmount: 10,
                      onPressed: (amount) => onTenPressed?.call(amount)),
                  SKBonusIconButton(
                      icon: const Image(
                          image: AssetImage('assets/icons/coins.png')),
                      maxAmount: 2,
                      onPressed: (amount) => onAllyPressed?.call(amount)),
                  SKBonusIconButton(
                      icon: const Image(
                          image: AssetImage('assets/icons/pari.png')),
                      maxAmount: 2,
                      onPressed: (amount) => onBetPressed?.call(amount)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SKText(text: AppLocalizations.of(context)!.roundScore),
                  currentRoundScore > 0
                      ? SKText(
                          text: ' +$currentRoundScore', color: Colors.green)
                      : SKText(text: ' $currentRoundScore', color: Colors.red)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
