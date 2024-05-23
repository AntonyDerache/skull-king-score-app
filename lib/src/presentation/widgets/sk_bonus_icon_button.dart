import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

class SKBonusIconButton extends StatefulWidget {
  const SKBonusIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    required this.maxAmount,
  });

  final Widget icon;
  final int maxAmount;
  final Function(int)? onPressed;

  @override
  State<SKBonusIconButton> createState() => _SKBonusIconButton();
}

class _SKBonusIconButton extends State<SKBonusIconButton> {
  int amount = 0;

  handleIconClick() {
    setState(() {
      amount + 1 > widget.maxAmount ? amount = 0 : amount++;
    });
    widget.onPressed?.call(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        height: 36,
        width: 36,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        alignment: Alignment.center,
        child: IconButton(
          icon: widget.icon,
          onPressed: () => handleIconClick(),
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
                ]),
            child: SKText(
              text: amount.toString(),
              fontSize: 10,
              color: Colors.black,
            )),
      )
    ]);
  }
}
