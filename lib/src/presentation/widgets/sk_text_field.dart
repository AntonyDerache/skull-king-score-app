import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';

class SKTextInput extends StatefulWidget {
  const SKTextInput(
      {super.key,
      this.placeholder = "Enter...",
      this.text = "",
      this.onChange});

  final String placeholder;
  final String text;
  final Function(String)? onChange;

  @override
  State<SKTextInput> createState() => _SKTextInput();
}

class _SKTextInput extends State<SKTextInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final ImageFilter blurFilter = ImageFilter.blur(sigmaX: 8, sigmaY: 8);
  final TextStyle textStyle =
      const TextStyle(color: Colors.white, decorationThickness: 0);

  @override
  Widget build(BuildContext context) {
    final InputDecoration defaultDecoration = InputDecoration(
        filled: true,
        fillColor: Colors.white.withAlpha(70),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        hintText: widget.placeholder,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        contentPadding: const EdgeInsets.only(left: 20, right: 20));

    return SizedBox(
      height: formHeight,
      child: ClipRect(
        child: BackdropFilter(
          filter: blurFilter,
          child: TextField(
            controller: _controller,
            style: textStyle,
            decoration: defaultDecoration,
            cursorColor: Colors.white,
            onChanged: (value) => {
              if (widget.onChange != null) {widget.onChange!(value)}
            },
          ),
        ),
      ),
    );
  }
}
