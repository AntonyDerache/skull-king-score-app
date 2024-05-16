import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';

class GameBackground extends StatelessWidget {
  const GameBackground({super.key});

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
          alignment: Alignment.center,
          child: const Image(
            height: 500,
            width: 500,
            opacity: AlwaysStoppedAnimation<double>(0.1),
            image: AssetImage('assets/images/logo_saturé.png'),
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
