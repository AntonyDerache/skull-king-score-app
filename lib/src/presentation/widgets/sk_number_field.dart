import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/utils/numeric_range_formatter.dart';

class SKNumberField extends StatefulWidget {
  const SKNumberField({
    super.key,
    required this.round,
    this.onChange,
  });

  final Function(String)? onChange;
  final int round;

  @override
  State<SKNumberField> createState() => _SKNumberField();
}

class _SKNumberField extends State<SKNumberField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final TextStyle textStyle =
      const TextStyle(color: lightColor, fontSize: defaultFontSize);

  @override
  Widget build(BuildContext context) {
    const InputDecoration defaultDecoration = InputDecoration(
      filled: false,
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: lightColor)),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: lightColor),
      ),
    );

    return SizedBox(
      height: 30,
      child: TextField(
        controller: _controller,
        style: textStyle,
        decoration: defaultDecoration,
        textAlign: TextAlign.center,
        cursorColor: Colors.white,
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        inputFormatters: [
          NumericRangeFormatter(min: 0, max: widget.round),
        ],
      ),
    );
  }
}
