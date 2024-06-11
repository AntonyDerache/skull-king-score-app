import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_backdrop_filter.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

enum ButtonVariant { plain, outlined }

class SKButton extends StatelessWidget {
  SKButton({
    super.key,
    this.label = 'label',
    this.onPressed,
    this.variant = ButtonVariant.plain,
    this.icon,
    this.textWeight = FontWeight.normal,
  });

  final String label;
  final Function? onPressed;
  final ButtonVariant? variant;
  final IconData? icon;
  final FontWeight textWeight;

  final ButtonStyle defaultStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(componentsRadius))),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    minimumSize: const Size.fromHeight(formHeight),
  );

  final ButtonStyle plainButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: lightColor.withAlpha(60),
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

    double blurValue = variant == ButtonVariant.plain ? 8.0 : 0;

    final child = SKBackdropFilter(
      hasClipRect: true,
      sigmaX: blurValue,
      sigmaY: blurValue,
      child: TextButton(
          style: buttonStyle,
          onPressed: () => onPressed?.call(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SKText(text: label, fontSize: 16, fontWeight: textWeight),
              if (icon != null) ...[const SizedBox(width: 20), Icon(icon)]
            ],
          )),
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
