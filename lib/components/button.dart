import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skull_king_score_app/constants/color.dart';

class Button extends StatelessWidget {
  Button({
    super.key,
    this.label = 'label',
    this.onPressed,
  });

  final String label;
  final Function? onPressed;

  final ImageFilter blurFilter = ImageFilter.blur(sigmaX: 8, sigmaY: 8);

  static final ButtonStyle defaultStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    minimumSize: const Size.fromHeight(48),
  );

  static final ButtonStyle plainButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: lightColor.withAlpha(89),
  );

  final ButtonStyle buttonStyle = defaultStyle.merge(plainButtonStyle);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: blurFilter,
        child: TextButton(
            style: buttonStyle,
            onPressed: () => onPressed?.call(),
            child: Text(label, style: const TextStyle(fontSize: 16))),
      ),
    );
  }
}
