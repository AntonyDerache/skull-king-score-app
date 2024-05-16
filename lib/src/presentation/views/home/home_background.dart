import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(1, .75),
              end: Alignment(0, 0),
              colors: <Color>[darkColor, secondaryColor],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.15,
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
        )
      ],
    );
  }
}
