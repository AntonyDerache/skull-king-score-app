import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class SKBonusIconButton extends StatelessWidget {
  const SKBonusIconButton({
    super.key,
    required this.icon,
    required this.maxAmount,
    required this.value,
    this.onPressed,
  }) : assert(value <= maxAmount);

  final Widget icon;
  final int maxAmount;
  final int value;
  final Function(int)? onPressed;

  void iconIsClicked() {
    onPressed?.call(value + 1 > maxAmount ? 0 : value + 1);
  }

  void resetIcon() {
    onPressed?.call(0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          child: Material(
            child: InkWell(
              child: Center(
                child: Ink(
                  width: 24,
                  height: 24,
                  child: Center(child: icon),
                ),
              ),
              onTap: () => iconIsClicked(),
              onLongPress: () => resetIcon(),
            ),
          ),
        ),
        Positioned(
          right: -3,
          bottom: -3,
          child: Container(
            height: 16,
            width: 16,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0.25,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: SKText(
              text: value.toString(),
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
