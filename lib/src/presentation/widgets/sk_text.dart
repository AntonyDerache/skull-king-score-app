import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';

class SkText extends StatelessWidget {
  const SkText({
    super.key,
    this.text = "Text",
    this.fontSize = 14,
    this.color = lightColor,
    this.fontFamily
  });

  final String text;
  final double fontSize;
  final Color color;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily
    )
    );
  }
}