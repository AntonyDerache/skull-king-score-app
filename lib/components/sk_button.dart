

import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/constants/color.dart';
import 'package:skull_king_score_app/constants/constants.dart';

enum ButtonVariant { plain, outlined }

class SKButton extends StatelessWidget {
  SKButton(
      {super.key,
      this.label = 'label',
      this.onPressed,
      this.variant = ButtonVariant.plain,
      this.icon});

  final String label;
  final Function? onPressed;
  final ButtonVariant? variant;
  final IconData? icon;

  final ButtonStyle defaultStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(componentsRadius))),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    minimumSize: const Size.fromHeight(formHeight),
  );


  final ButtonStyle plainButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: lightColor.withAlpha(89),
  );

  final ButtonStyle outlinedButtonStyle = TextButton.styleFrom(
    foregroundColor: lightColor,
    backgroundColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = defaultStyle;

    switch (variant) {
      case ButtonVariant.outlined:
        buttonStyle = buttonStyle.merge(outlinedButtonStyle);
        break;
      default:
        buttonStyle = buttonStyle.merge(plainButtonStyle);
    }

    ImageFilter filterBlur = variant == ButtonVariant.plain
        ? ImageFilter.blur(sigmaX: 8, sigmaY: 8)
        : ImageFilter.blur(sigmaX: 0, sigmaY: 0);

    final child = ClipRRect(
      child: BackdropFilter(
        filter: filterBlur,
        child: TextButton(
            style: buttonStyle,
            onPressed: () => onPressed?.call(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: const TextStyle(fontSize: 16)),
                if (icon != null)
                  const SizedBox(width: 20),
                  Icon(icon)
              ],
            )),
      ),
    );

    return variant == ButtonVariant.plain
        ? child
        : DottedBorder(
            color: lightColor,
            borderType: BorderType.RRect,
            radius: const Radius.circular(componentsRadius),
            child: child,
          );
  }
}
