import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skull_king_score_app/constants/color.dart';
import 'package:skull_king_score_app/constants/constants.dart';

class SKTextInput extends StatelessWidget {
  SKTextInput({super.key, this.placeholder = "Enter..."});

  final String placeholder;

  final ImageFilter blurFilter = ImageFilter.blur(sigmaX: 8, sigmaY: 8);
  final TextStyle textStyle =
      const TextStyle(color: Colors.white, decorationThickness: 0);

  @override
  Widget build(BuildContext context) {
    final InputDecoration defaultDecoration = InputDecoration(
        filled: true,
        fillColor: lightColor.withAlpha(89),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        contentPadding: const EdgeInsets.only(left: 20, right: 20)
        );

    return SizedBox(
      height: formHeight,
      child: ClipRect(
        child: BackdropFilter(
          filter: blurFilter,
          child: TextField(
            style: textStyle,
            decoration: defaultDecoration,
            cursorColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
