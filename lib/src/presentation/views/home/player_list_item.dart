import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text_field.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem(
      {super.key,
      required this.animation,
      required this.index,
      required this.onChange,
      required this.text});

  final String text;
  final int index;
  final Animation<double> animation;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: Column(
        children: [
          SKTextInput(
            text: text,
            placeholder: "Enter player's name",
            onChange: (value) => onChange(value),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
