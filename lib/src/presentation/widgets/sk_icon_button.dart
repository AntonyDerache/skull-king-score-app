import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_backdrop_filter.dart';

class SKIconButton extends StatelessWidget {
  const SKIconButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final Icon icon;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return SKBackdropFilter(
      hasClipRect: true,
      sigmaX: 8,
      sigmaY: 8,
      child: IconButton(
          style: IconButton.styleFrom(
              backgroundColor: lightColor.withAlpha(60),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(componentsRadius)))),
          constraints:
              const BoxConstraints(minHeight: formHeight, minWidth: formHeight),
          icon: icon,
          color: lightColor,
          onPressed: () => onPressed?.call()),
    );
  }
}
