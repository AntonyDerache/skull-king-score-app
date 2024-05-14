import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/components/sk_text.dart';

class SkIconButton extends StatelessWidget {
  const SkIconButton({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        height: 36,
        width: 36,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        alignment: Alignment.center,
        child: IconButton(
          icon: icon,
          onPressed: null,
        ),
      ),
      Positioned(
        right: -3,
        bottom: -3,
        child: Container(
            height: 14,
            width: 14,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0.25,
                    blurRadius: 7,
                    offset: const Offset(0, 0),
                  )
                ]),
            child: const SkText(
              text: '0',
              fontSize: 9,
              color: Colors.black,
            )),
      )
    ]);
  }
}
