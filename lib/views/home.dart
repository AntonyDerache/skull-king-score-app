import 'package:flutter/material.dart';
import 'package:skull_king_score_app/components/sk_button.dart';
import 'package:skull_king_score_app/components/sk_text_field.dart';
import 'package:skull_king_score_app/layout/background.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Stack(
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  child: const Image(
                      height: 250,
                      width: 250,
                      opacity: AlwaysStoppedAnimation<double>(0.5),
                      image: AssetImage('assets/images/logo.png'))),
              Container(
                alignment: Alignment.topCenter,
                child: const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text('Skull King',
                      style: TextStyle(
                          fontFamily: 'Allura',
                          fontSize: 82,
                          color: Colors.white)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SKTextInput(placeholder: "Enter player's name"),
                    const SizedBox(height: 10),
                    SKTextInput(placeholder: "Enter player's name"),
                    const SizedBox(height: 10),
                    SKTextInput(placeholder: "Enter player's name"),
                    const SizedBox(height: 10),
                    SKButton(
                      label: 'Add new player',
                      onPressed: () => debugPrint('toto'),
                      variant: ButtonVariant.outlined,
                      icon: Icons.add,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SKButton(
                  label: 'Start',
                  onPressed: () => debugPrint('toto'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
