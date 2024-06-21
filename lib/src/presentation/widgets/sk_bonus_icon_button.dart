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

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          alignment: Alignment.center,
          child: IconButton(
            icon: icon,
            onPressed: () => iconIsClicked(),
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
              borderRadius: const BorderRadius.all(Radius.circular(100)),
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
