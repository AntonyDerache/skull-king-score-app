import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';

class SKText extends StatelessWidget {
  const SKText({
    super.key,
    this.text = "Text",
    this.fontSize = 14,
    this.color = lightColor,
    this.fontFamily,
    this.fontWeight = FontWeight.normal,
  });

  final String text;
  final double fontSize;
  final Color color;
  final String? fontFamily;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontFamily: fontFamily,
            fontWeight: fontWeight));
  }
}
